 
 

local v1 = {};
local Debris = game:GetService("Debris");
local TweenService = game:GetService("TweenService");
local workspace_Effects = workspace.Effects;
local script_DistortionMesh = script.DistortionMesh;

function v1.Play(p2: table) -- Line: 20
    -- upvalues: script_DistortionMesh (copy), workspace_Effects (copy), TweenService (copy), Debris (copy)
    local v3 = script_DistortionMesh:Clone();
    v3.CFrame = p2.Position;
    v3.Parent = workspace_Effects;
    v3.Transparency = p2.StartDistortion;
    v3.Size = Vector3.new(p2.StartRadius, p2.StartRadius, p2.StartRadius);
    TweenService:Create(v3, TweenInfo.new(p2.Duration, p2.EasingStyle, p2.EasingDirection), {
        Size = Vector3.new(p2.EndRadius, p2.EndRadius, p2.EndRadius),
        Transparency = p2.EndDistortion
    }):Play();
    Debris:AddItem(v3, p2.Duration);
end;

return v1;