const flecs = @import("flecs");
pub const mod_2d = @import("../2d-physics/init.zig").components;

pub usingnamespace @import("player.zig");
pub usingnamespace @import("enemy.zig");
pub usingnamespace @import("shooter.zig");

pub fn init(world: *flecs.World) void {
    _ = world.newComponent(Player);
    _ = world.newComponent(Enemy);
    _ = world.newComponent(Shooter);
}