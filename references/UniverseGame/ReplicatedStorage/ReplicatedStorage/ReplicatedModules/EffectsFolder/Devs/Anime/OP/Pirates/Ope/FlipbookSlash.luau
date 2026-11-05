  

 

local TweenService = game:GetService("TweenService");
local ReplicatedLibrary = game:GetService("ReplicatedStorage").ReplicatedModules.ReplicatedLibrary;
local AssetHandler = require(ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(ReplicatedLibrary.ParticleHandler);
local u1 = AssetHandler.GetAsset("Particles/LMB/FlipbookSlash", {
    AbilityName = "Ope"
});
local u2 = AssetHandler.GetAsset("Particles/LMB/SlashBook", {
    AbilityName = "Ope"
});

return function(p3) -- Line: 11
    -- upvalues: u2 (copy), ParticleHandler (copy), u1 (copy), TweenService (copy)
    local Origin = p3.Origin;
    local Time = p3.Time;
    local EndCFrame = p3.EndCFrame;
    local _ = p3.SecondOffset;
    local Size = p3.Size;
    local SurfaceDirection = p3.SurfaceDirection;
    local Color = p3.Color;
    local v4 = p3.Flipbook or u2;
    local v5 = v4:GetChildren();
    local v6 = ParticleHandler.GetUnusualHSVData({
        Character = p3.Character
    });
    local v7 = Time / #v5;
    local v8 = Origin * EndCFrame;
    local v9 = (p3.SlashMesh or u1):Clone();
    v9.CFrame = Origin;
    v9.Decal.Face = SurfaceDirection;
    v9.Decal.Color3 = Color;
    v9.Mesh.Scale = Size;
    v9.CastShadow = false;

    if v6 ~= nil then
        v9.Color = ParticleHandler.HSVShift(v9.Color, v6);
        local Color32 = v9.Decal.Color3;
        local v10 = math.max(Color32.R, Color32.G, Color32.B);
        local v11 = ParticleHandler.HSVShift(Color3.new(Color32.R / v10, Color32.G / v10, Color32.B / v10), v6);
        local v12 = Color3.new(v11.R * v10, v11.G * v10, v11.B * v10);
        v9.Decal.Color3 = v12;
    end;

    v9.Parent = workspace.Effects;
    task.delay(Time * 5, v9.Destroy, v9);
    local DoWeld = p3.DoWeld;
    local v13;

    if DoWeld then
        v9.Massless = true;
        v9.CanCollide = false;
        v9.Anchored = false;
        v9.CFrame = DoWeld.Attach.CFrame;
        v13 = ParticleHandler.AttachTo(v9, {
            Part = DoWeld.Attach,
            Offset = DoWeld.Offset
        });
    else
        v13 = nil;
    end;

    for i = 1, #v5 do
        local v14 = task.wait(v7);

        if not v9:IsDescendantOf(game) then
            break;
        end;

        v9.Decal.Texture = v4[tostring(i)].Texture;

        if v13 then
            TweenService:Create(v13, TweenInfo.new(v14, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                C0 = DoWeld.Offset:Lerp(EndCFrame, i / #v5)
            }):Play();
        else
            TweenService:Create(v9, TweenInfo.new(v14, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                CFrame = Origin:Lerp(v8, i / #v5)
            }):Play();
        end;
    end;

    v9:Destroy();
end;