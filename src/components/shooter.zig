const flecs = @import("flecs");

pub const Shooter = struct {
    bullet: flecs.Entity,
    target: flecs.Entity
};