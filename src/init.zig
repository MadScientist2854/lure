const std = @import("std");
const flecs = @import("flecs");
const rl = @import("raylib");
const components = @import("components/export.zig");
const systems = @import("systems/export.zig");
const mod_2d = @import("2d-physics/init.zig");

pub fn init(world: *flecs.World, allocator: *std.mem.Allocator) std.mem.Allocator.Error!void {
    // init modules
    mod_2d.init(world);

    // init components and systems
    components.init(world);
    systems.init(world);

    // load resources

    // add entities
    const eplayer = world.new();
    const eenemy = world.new();
    const ebullet = world.new();
    const eshooter = world.new();

    // set components on entities
    world.set(eplayer, &components.mod_2d.Rectangle {
        .size = rl.Vector2 { .x = 25, .y = 60 },
        .color = rl.DARKGREEN
    });
    world.set(eplayer, &components.mod_2d.Position2D {
        .x = 100,
        .y = 100
    });
    world.set(eplayer, &components.mod_2d.Velocity2D {
        .x = 0,
        .y = 0
    });
    world.add(eplayer, components.Player);

    world.set(ebullet, &components.mod_2d.Rectangle {
        .size = rl.Vector2 { .x = 10, .y = 10 },
        .color = rl.BLACK
    });
    world.set(ebullet, &components.mod_2d.Position2D {
        .x = 880,
        .y = 525
    });
    world.set(ebullet, &components.mod_2d.Velocity2D {
        .x = -1601,
        .y = 0
    });

    world.set(eshooter, &components.mod_2d.Rectangle {
        .size = rl.Vector2 { .x = 25, .y = 60 },
        .color = rl.BLUE
    });
    world.set(eshooter, &components.mod_2d.Position2D {
        .x = 0,
        .y = 0
    });
    world.set(eshooter, &components.mod_2d.Velocity2D {
        .x = 0,
        .y = 0
    });
    world.set(eshooter, &components.Shooter {
        .bullet = ebullet,
        .target = eplayer
    });

    world.set(eenemy, &components.mod_2d.Rectangle {
        .size = rl.Vector2 { .x = 25, .y = 60 },
        .color = rl.MAROON
    });
    world.set(eenemy, &components.mod_2d.Position2D {
        .x = 900,
        .y = 500
    });
    world.set(eenemy, &components.mod_2d.Velocity2D {
        .x = 0,
        .y = 0
    });
    world.set(eenemy, &components.Enemy {
        .target = eplayer
    });
}

pub fn deinit(world: *flecs.World, arena: *std.heap.ArenaAllocator) void {
    // raylib deallocations can also go here, by doing a query on world, or just add triggers for those

    arena.deinit();
}