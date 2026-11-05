  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local TweenService = game:GetService("TweenService");
local v1 = game:GetService("ReplicatedStorage"):FindFirstChild("Client Assets");
local Frames = v1.Assets.Abilities.Anubis.Flipbooks.Slash.Frames;
local u2 = Frames:GetChildren();
local Base = v1.Assets.Abilities.Anubis.Flipbooks.Slash.Base;
local Players = game:GetService("Players");

return function(p3) -- Line: 16
    -- upvalues: ParticleHandler (copy), u2 (copy), Base (copy), Players (copy), Frames (copy), TweenService (copy)
    local v4 = ParticleHandler.TranslateToCFrame(p3.Origin);
    local Offset = p3.Offset;
    local Time = p3.Time;
    local Size = p3.Size;
    local SurfaceDirection = p3.SurfaceDirection;
    local Color = p3.Color;
    local _ = p3.Attach;
    local Character = p3.Character;

    if not (v4 and Offset) then
        return;
    end;

    local u5 = {};
    local u6 = v4 * Offset;
    local u7 = Time / #u2;
    local u8 = u6 * p3.EndCFrame;
    local u9 = Base:Clone();
    u9.CFrame = u6;
    u9.Decal.Face = SurfaceDirection;
    u9.Mesh.Scale = Size;
    u9.Parent = workspace.Effects;

    if typeof(Color) == "table" then
        u9.Decal.Color3 = Color[math.random(1, #Color)];
    else
        u9.Decal.Color3 = Color;
    end;

    local v10;

    if Character then
        v10 = Character:FindFirstChild("Stand");
    else
        v10 = Character;
    end;

    if v10 and (v10:FindFirstChild("Sword") and v10:FindFirstChild("Sword"):GetAttribute("SlashColor")) then
        u9.Decal.Color3 = v10:FindFirstChild("Sword"):GetAttribute("SlashColor");
    end;

    local v11 = Players:GetPlayerFromCharacter(Character);
    local u12 = 0;

    if v11 then
        local v13 = not v11 and "" or v11.Data.Skin:GetAttribute("SkinName");
        local v14 = ParticleHandler.GetSkinInfo(v13);

        if v14 and v14.Metadata then
            if v14.Metadata.HueShift then
                u9.Decal.Color3 = ParticleHandler.HueShift(u9.Decal.Color3, v14.Metadata.HueShift);
            end;

            if v14.Metadata.HSVShift then
                u9.Decal.Color3 = ParticleHandler.HSVShift(u9.Decal.Color3, v14.Metadata.HSVShift);
            end;
        end;

        if v11 and v11.Data.Skin:GetAttribute("UnusualHueId") then
            u12 = u12 + v11.Data.Skin:GetAttribute("UnusualHueId") * 5;
        end;

        if u12 > 0 and (v14 and (v14.Metadata and v14.Metadata.SaturationThreshold)) then
            u9.Decal.Color3 = ParticleHandler.HSVShift(u9.Decal.Color3, {
                SaturationThreshold = v14.Metadata.SaturationThreshold
            });
        end;

        u9.Decal.Color3 = ParticleHandler.HSVShift(u9.Decal.Color3, {
            HueShift = u12
        });
    end;

    task.delay(Time, u9.Destroy, u9);

    for i = 1, #u2 do
        task.delay(u7 * i, function() -- Line: 88
            -- upvalues: u9 (copy), Color (copy), u5 (ref), ParticleHandler (ref), u12 (ref), Frames (ref), i (copy), TweenService (ref), u7 (copy), u6 (copy), u8 (copy), u2 (ref)
            if not u9:IsDescendantOf(game) then
                return;
            end;

            if typeof(Color) == "table" then
                u5 = Color;
                u9.Decal.Color3 = u5[math.random(1, #u5)];
                u9.Decal.Color3 = ParticleHandler.HSVShift(u9.Decal.Color3, {
                    HueShift = u12
                });
            end;

            u9.Decal.Texture = Frames[tostring(i)].Texture;
            TweenService:Create(u9, TweenInfo.new(u7, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                CFrame = u6:Lerp(u8, i / #u2)
            }):Play();
        end);
    end;
end;