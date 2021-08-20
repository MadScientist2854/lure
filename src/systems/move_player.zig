const flecs = @import("flecs");
const rl = @import("raylib");
const components = @import("../components/export.zig");

pub fn move_player(it: *flecs.ecs_iter_t) callconv(.C) void {
    const velocities = it.column(components.mod_2d.Velocity2D, 2);
    // const rectangles = it.column(components.mod_2d.Rectangle, 3);

    var i: usize = 0;
    while (i < it.count) : ( i += 1 ) {
        // const rectangle = rectangles[i];
        // const size = rectangle.size;
        // const color = rectangle.color;
        const vel = &velocities[i];

        // reset velocity
        vel.x = 0;
        vel.y = 0;

        // Test for input and set position
        if (rl.IsKeyDown(rl.KEY_RIGHT) or rl.IsKeyDown(rl.KEY_D)) vel.x = 10;
        if (rl.IsKeyDown(rl.KEY_LEFT) or rl.IsKeyDown(rl.KEY_A)) vel.x = -10;
        if (rl.IsKeyDown(rl.KEY_UP) or rl.IsKeyDown(rl.KEY_W)) vel.y = -10;
        if (rl.IsKeyDown(rl.KEY_DOWN) or rl.IsKeyDown(rl.KEY_S)) vel.y = 10;
    }
}