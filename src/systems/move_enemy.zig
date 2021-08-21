const flecs = @import("flecs");
const rl = @import("raylib");
const rm = @import("raymath");
const components = @import("../components/export.zig");

const ENEMY_SPEED = 4;
pub fn move_enemy(it: *flecs.ecs_iter_t) callconv(.C) void {
    const enemies = it.column(components.Enemy, 1);
    const positions = it.column(components.mod_2d.Position2D, 2);
    const velocities = it.column(components.mod_2d.Velocity2D, 3);
    // const rectangles = it.column(components.mod_2d.Rectangle, 4);

    var i: usize = 0;
    while (i < it.count) : ( i += 1 ) {
        // const rectangle = rectangles[i];
        // const size = rectangle.size;
        // const color = rectangle.color;
        const pos = &positions[i];
        const vel = &velocities[i];
        const vel_vec = rm.Vector2 { .x = vel.x, .y = vel.y };
        var world = flecs.World { .world = it.world.? };
        const target = world.get(enemies[i].target, components.mod_2d.Position2D).?;

        // get direction
        const enemy_pos = rm.Vector2 { .x = pos.x, .y = pos.y };
        const target_pos = rm.Vector2 { .x = target.x, .y = target.y };
        const desired_velocity = target_pos.Subtract(enemy_pos).Normalize().Scale(ENEMY_SPEED);
        const steering_force = desired_velocity.Subtract(vel_vec);

        // move towards direction
        vel.x += steering_force.x;
        vel.y += steering_force.y;
    }
}