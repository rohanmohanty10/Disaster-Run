  

 

local LocalPlayer = game.Players.LocalPlayer;
local CurrentCamera = workspace.CurrentCamera;
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = ReplicatedStorage["Client Assets"].Goku["Goku Modules"];
local CameraShaker = require(ReplicatedStorage.ClientModules.CameraShaker);
local Effects = require(v1.Effects);
local secondaryEffectModule = require(v1.secondaryEffectModule);
secondaryEffectModule.Init();

return function(u2, u3) -- Line: 10
    -- upvalues: LocalPlayer (copy), Effects (copy), secondaryEffectModule (copy), CameraShaker (copy), CurrentCamera (copy)
    local u4 = LocalPlayer:FindFirstChildOfClass("PlayerGui");
    pcall(function() -- Line: 12
        -- upvalues: u2 (copy), Effects (ref), u3 (copy), u4 (copy), secondaryEffectModule (ref), CameraShaker (ref), CurrentCamera (ref)
        if u2 == "Circle" then
            Effects:GenerateCircle(u3);

            return;
        end;

        if u2 == "Wave" then
            Effects:GenerateWave(u3);

            return;
        end;

        if u2 == "Sphere" then
            Effects:GenerateSphere(u3);

            return;
        end;

        if u2 == "Cube" then
            Effects:GenerateCube(u3);

            return;
        end;

        if u2 == "Cylinder" then
            Effects:UICylinder(u3);

            return;
        end;

        if u2 == "Swirl" then
            Effects:GenerateSwirl(u3);

            return;
        end;

        if u2 == "Dash" then
            Effects:GenerateDash(u3);

            return;
        end;

        if u2 == "Glow" then
            Effects:GenerateGlowAura(u3);

            return;
        end;

        if u2 == "Shadow" then
            Effects:GenerateShadow(u3);

            return;
        end;

        if u2 == "Transform" then
            u3.PlayerGui = u4;
            u3.Props = "Transform";
            Effects:MakeGui(u3);

            return;
        end;

        if u2 == "Text" then
            u3.PlayerGui = u4;
            u3.Props = "Text";
            Effects:MakeGui(u3);

            return;
        end;

        if u2 == "Mood" then
            secondaryEffectModule.Variants.MeshEffect:Render(u3);

            return;
        end;

        if u2 == "Shake" then
            local v6 = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(p5) -- Line: 42
                -- upvalues: CurrentCamera (ref)
                CurrentCamera.CFrame = CurrentCamera.CFrame * p5;
            end);
            v6:Start();
            v6:ShakeOnce(u3.Magnitude, u3.Roughness, u3.FadeIn, u3.FadeOut);

            return;
        end;

        if u2 ~= "TransformShake" then
            if u2 == "Earthquake" then
                local v8 = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(p7) -- Line: 54
                    -- upvalues: CurrentCamera (ref)
                    CurrentCamera.CFrame = CurrentCamera.CFrame * p7;
                end);
                v8:Start();
                v8:Shake(CameraShaker.Presets.Earthquake);
            end;

            return;
        end;

        local v10 = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(p9) -- Line: 48
            -- upvalues: CurrentCamera (ref)
            CurrentCamera.CFrame = CurrentCamera.CFrame * p9;
        end);
        v10:Start();
        v10:Shake(CameraShaker.Presets.Explosion);
    end);
end;