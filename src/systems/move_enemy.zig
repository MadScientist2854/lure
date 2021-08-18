const flecs = @import("flecs");
const rl = @import("raylib");
const components = @import("../components/export.zig");

pub fn move_enemy(it: *flecs.ecs_iter_t) callconv(.C) void {
    const enemies = it.column(components.Enemy, 1);
    const positions = it.column(components.mod_2d.Position2D, 2);
    // const rectangles = it.column(components.mod_2d.Rectangle, 3);

    var i: usize = 0;
    while (i < it.count) : ( i += 1 ) {
        // const rectangle = rectangles[i];
        // const size = rectangle.size;
        // const color = rectangle.color;
        const pos = &positions[i];

        // Test for input and set position
        if (rl.IsKeyDown(rl.KEY_RIGHT) or rl.IsKeyDown(rl.KEY_D)) pos.x += 10;
        if (rl.IsKeyDown(rl.KEY_LEFT) or rl.IsKeyDown(rl.KEY_A)) pos.x -= 10;
        if (rl.IsKeyDown(rl.KEY_UP) or rl.IsKeyDown(rl.KEY_W)) pos.y -= 10;
        if (rl.IsKeyDown(rl.KEY_DOWN) or rl.IsKeyDown(rl.KEY_S)) pos.y += 10;
    }
}