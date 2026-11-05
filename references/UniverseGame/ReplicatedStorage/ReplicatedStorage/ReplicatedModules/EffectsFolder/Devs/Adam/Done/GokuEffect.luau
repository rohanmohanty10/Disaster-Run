  

 

return function(p1, u2) -- Line: 1
    local GokuEffects = require(script.GokuEffects);
    local SecGokuEffects = require(script.SecGokuEffects);
    SecGokuEffects.Init();
    local PlayerGui = game.Players.LocalPlayer.PlayerGui;
    ({
        Circle = function() -- Line: 7
            -- upvalues: GokuEffects (copy), u2 (copy)
            GokuEffects:GenerateCirlce(u2);
        end,

        Wave = function() -- Line: 10
            -- upvalues: GokuEffects (copy), u2 (copy)
            GokuEffects:GenerateWave(u2);
        end,

        Sphere = function() -- Line: 13
            -- upvalues: GokuEffects (copy), u2 (copy)
            GokuEffects:GenerateSphere(u2);
        end,

        Cube = function() -- Line: 16
            -- upvalues: GokuEffects (copy), u2 (copy)
            GokuEffects:GenerateCube(u2);
        end,

        Cylinder = function() -- Line: 19
            -- upvalues: GokuEffects (copy), u2 (copy)
            GokuEffects:UICylinder(u2);
        end,

        Swirl = function() -- Line: 22
            -- upvalues: GokuEffects (copy), u2 (copy)
            GokuEffects:GenerateSwirl(u2);
        end,

        Dash = function() -- Line: 25
            -- upvalues: GokuEffects (copy), u2 (copy)
            GokuEffects:GenerateDash(u2);
        end,

        Glow = function() -- Line: 28
            -- upvalues: GokuEffects (copy), u2 (copy)
            GokuEffects:GenerateGlowAura(u2);
        end,

        Shadow = function() -- Line: 31
            -- upvalues: GokuEffects (copy), u2 (copy)
            GokuEffects:GenerateShadow(u2);
        end,

        Transform = function() -- Line: 34
            -- upvalues: u2 (copy), PlayerGui (copy), GokuEffects (copy)
            u2.PlayerGui = PlayerGui;
            u2.Type = "Transform";
            GokuEffects:MakeGui(u2);
        end,

        Text = function() -- Line: 39
            -- upvalues: u2 (copy), PlayerGui (copy), GokuEffects (copy)
            u2.PlayerGui = PlayerGui;
            u2.Type = "Text";
            GokuEffects:MakeGui(u2);
        end,

        Mood = function() -- Line: 44
            -- upvalues: SecGokuEffects (copy), u2 (copy)
            SecGokuEffects.Variants.MeshEffect:Render(u2);
        end,

        Shake = function() -- Line: 47
        end,

        TransformShake = function() -- Line: 54
        end,

        Earthquake = function() -- Line: 61
        end
    })[p1]();
end;