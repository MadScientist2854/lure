const std = @import("std");
const rl = @import("raylib");
const flecs = @import("flecs");
const cm = @import("chipmunk");
const init = @import("init.zig");

pub fn main() !void {
    // FLECS initialization
    var world = flecs.World.init();
    defer world.deinit();
    world.setTargetFps(60);

    // raylib initialization
    const screen_width = 1600;
    const screen_height = 800;
    rl.InitWindow(screen_width, screen_height, "Title");
    defer rl.CloseWindow();
    rl.SetTargetFPS(60);

    // physac initialization
    rl.InitPhysics();
    defer rl.ClosePhysics();

    // game initialization
    var buffer: [2048]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    var arena = std.heap.ArenaAllocator.init(&fba.allocator);
    const allocator = &arena.allocator;

    const space = cm.cpSpaceNew().?;
    try init.init(&world, space, allocator);
    defer init.deinit(&world, &arena);
    defer cm.cpSpaceFree(space);

    // Main game loop
    while (!rl.WindowShouldClose()) {
        world.progress(0);
    }
}