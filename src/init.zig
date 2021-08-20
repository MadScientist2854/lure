const std = @import("std");
const flecs = @import("flecs");
const rl = @import("raylib");
const components = @import("components/export.zig");
const systems = @import("systems/export.zig");

pub fn init(world: *flecs.World, allocator: *std.mem.Allocator) std.mem.Allocator.Error!void {
    // add components and systems
    components.init(world);
    systems.init(world);

    // load resources

    // add entities
    const eplayer = world.new();
    world.set(eplayer, &components.mod_2d.Rectangle {
        .size = rl.Vector2 { .x = 50, .y = 125 },
        .color = rl.DARKGREEN
    });
    world.set(eplayer, &components.mod_2d.Position2D {
        .x = 100,
        .y = 100
    });
    world.add(eplayer, components.Player);

    const eenemy = world.new();
    world.set(eenemy, &components.mod_2d.Rectangle {
        .size = rl.Vector2 { .x = 50, .y = 125 },
        .color = rl.MAROON
    });
    world.set(eenemy, &components.mod_2d.Position2D {
        .x = 500,
        .y = 500
    });
    world.set(eenemy, &components.Enemy {
        .target = eplayer
    });
}

pub fn deinit(world: *flecs.World, arena: *std.heap.ArenaAllocator) void {
    // raylib deallocations can also go here, by doing a query on world, or just add triggers for those

    arena.deinit();
}