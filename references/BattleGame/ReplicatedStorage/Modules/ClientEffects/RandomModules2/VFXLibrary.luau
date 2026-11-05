 

local v1 = {};
local l__Modules__1 = script.Modules;
v1.Beam = require(l__Modules__1.Beam);
v1.Mesh = require(l__Modules__1.Mesh);
v1.mesh_emit = require(l__Modules__1.mesh_emit);
v1.freeze = require(l__Modules__1.freeze);
v1.unfreeze = require(l__Modules__1.unfreeze);
v1.Lighting = require(l__Modules__1.Lighting);
v1.Particles = require(l__Modules__1.Particles);
v1.Highlight = require(l__Modules__1.Highlight);
v1.BezierProjectile = require(l__Modules__1.BezierProjectile);
for _, v2 in pairs({
    v1.Beam,
    v1.Mesh,
    v1.Lighting,
    v1.Particles,
    v1.Highlight
}) do
    for v3, v4 in pairs(v2) do
        if type(v4) == "function" then
            v1[v3] = v4;
        end;
    end;
end;
return v1;