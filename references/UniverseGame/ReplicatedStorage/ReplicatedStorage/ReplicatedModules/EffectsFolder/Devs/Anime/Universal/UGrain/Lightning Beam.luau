  

 

local TweenService = game:GetService("TweenService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
game:GetService("RunService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
local u1 = Random.new();
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.EffectsHandler);
local _ = Players.LocalPlayer;

return function(p2) -- Line: 19
    -- upvalues: ParticleHandler (copy), u1 (copy), TweenService (copy)
    local v3 = p2 or {};
    local v4 = v3.HSVData or ParticleHandler.GetUnusualHSVData({
        Player = v3.Player or v3.AttackerPlayer,
        Character = v3.Character or v3.Attacker
    });
    local Start = v3.Start;
    local End = v3.End;

    if Start and End then
        local v5 = v3.Amount or 15;
        local v6 = ColorSequence.new(ParticleHandler.TryHSVShift(v3.Color or Color3.fromRGB(105, 141, 192), v4));
        local v7 = v3.Parent or workspace.Terrain;
        local v8 = v3.Life or 10;
        local v9 = v3.CurveSize or 1;
        local v10 = v3.Range or 10;
        local v11 = v3.Thickness or 0.35;
        local v12 = u1:NextNumber(-v10, v10) / 10;
        local v13 = u1:NextNumber(v8 / 2, v8) / 10;
        local v14 = TweenInfo.new(v13, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
        local Attachment = Instance.new("Attachment");
        Attachment.WorldCFrame = CFrame.new(Start);
        Attachment.Parent = v7;
        task.delay(v13 * 2, Attachment.Destroy, Attachment);

        for i = 0, v5 do
            local v15 = u1:NextNumber(-v10, v10);
            local v16 = u1:NextNumber(-v10, v10);
            local v17 = Vector3.new(v15, v16, u1:NextNumber(-v10, v10)) / 10;
            local Attachment2 = Instance.new("Attachment");
            Attachment2.WorldCFrame = CFrame.new(Start:Lerp(End, (i + 1) / v5) + v17) * CFrame.fromEulerAnglesXYZ(u1:NextNumber(-45, 45), u1:NextNumber(-45, 45), u1:NextNumber(-180, 180));
            Attachment2.Parent = v7;
            task.delay(v13 * 2, Attachment2.Destroy, Attachment2);
            local Beam = Instance.new("Beam");
            Beam.Name = "Beam " .. i;
            Beam.Attachment0 = Attachment;
            Beam.Attachment1 = Attachment2;
            Beam.TextureMode = Enum.TextureMode.Static;
            Beam.TextureLength = 3;
            Beam.TextureSpeed = 1.4;
            Beam.LightEmission = 0;
            Beam.LightInfluence = 0;
            Beam.Brightness = 5;
            Beam.Color = v6;
            Beam.Transparency = NumberSequence.new(0);
            Beam.Width0 = v11;
            Beam.Width1 = v11;
            Beam.Segments = v5;
            Beam.CurveSize0 = v9;
            Beam.CurveSize1 = v9;
            Beam:SetTextureOffset(Beam.TextureLength * i);
            Beam.Parent = Attachment;
            task.delay(v13 * 2, Beam.Destroy, Beam);
            local v18 = math.sin((i + 1) / v5 * 3.141592653589793) * v12;
            TweenService:Create(Attachment2, v14, {
                CFrame = Attachment2.CFrame * CFrame.fromEulerAnglesXYZ(u1:NextNumber(-45, 45), u1:NextNumber(-45, 45), u1:NextNumber(-180, 180)) + Vector3.new(0, v18, 0)
            }):Play();
            TweenService:Create(Beam, v14, {
                Width0 = 0,
                Width1 = 0
            }):Play();
            Attachment = Attachment2;
        end;

        return Start, End;
    end;
end;