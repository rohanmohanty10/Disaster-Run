 
 

local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local PlayerGui = game:GetService("Players").LocalPlayer.PlayerGui;
local u1 = { "Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg" };

return function(p2) -- Line: 13
    -- upvalues: PlayerGui (copy), TweenService (copy), u1 (copy), Debris (copy)
    local Character = p2.Character;
    local u3 = p2.Duration or 1;
    local u4 = p2.Frequency or 0.035;
    local u5 = p2.Transparency or 0.5;
    local u6 = p2.DisappearTime or 0.5;
    local u7 = p2.StartColor or Color3.fromRGB(209, 93, 255);
    local u8 = p2.FinalColor or Color3.fromRGB(116, 255, 114);
    local u9 = p2.Viewport or false;
    Character.Archivable = true;
    local u10 = script.ViewportAfterImage:Clone();
    u10.Parent = PlayerGui;
    local u11 = os.clock() + u3;
    task.spawn(function() -- Line: 29
        -- upvalues: u11 (copy), u9 (copy), u10 (copy), u7 (copy), Character (copy), TweenService (ref), u6 (copy), u8 (copy), u1 (ref), u5 (copy), Debris (ref), u4 (copy), u3 (copy)
        while u11 > os.clock() do
            if u9 == true then
                local v12 = u10.ViewportFrame:Clone();
                v12.Visible = true;
                v12.CurrentCamera = workspace.CurrentCamera;
                v12.Parent = u10;
                v12.ImageTransparency = 0;
                v12.ImageColor3 = u7;
                v12.Ambient = u7;
                v12.LightColor = u7;
                local v13 = Character:Clone();

                for _, descendant in pairs(v13:GetDescendants()) do
                    if descendant:IsA("Script") or (descendant:IsA("LocalScript") or (descendant:IsA("Sound") or (descendant:IsA("ParticleEmitter") or descendant.Name == "BallDisplay"))) then
                        descendant:Destroy();
                    end;
                end;

                v13.Parent = v12;
                TweenService:Create(v12, TweenInfo.new(u6), {
                    ImageTransparency = 1,
                    ImageColor3 = u8,
                    Ambient = u8,
                    LightColor = u8
                }):Play();
            else
                for _, v in pairs(u1) do
                    local v14 = Character:FindFirstChild(v):Clone();

                    if v14.Name == "Head" then
                        v14:Destroy();
                        v14 = Character.Head.FaceContainer:Clone();
                    end;

                    for _, descendant in pairs(v14:GetDescendants()) do
                        if descendant:IsA("Decal") or (descendant:IsA("Weld") or (descendant:IsA("Motor6D") or descendant:IsA("Attachment"))) then
                            descendant:Destroy();
                        end;
                    end;

                    v14.Size = v14.Size / 1.1;
                    v14.Material = Enum.Material.Neon;
                    v14.Transparency = u5;
                    v14.Color = u7;
                    v14.Anchored = true;
                    v14.CanCollide = false;
                    v14.CanQuery = false;
                    v14.Massless = true;
                    v14.Parent = workspace.Effects;
                    TweenService:Create(v14, TweenInfo.new(u6), {
                        Color = u8
                    }):Play();
                    TweenService:Create(v14, TweenInfo.new(u6), {
                        Transparency = 1
                    }):Play();
                    Debris:AddItem(v14, u6);
                end;
            end;

            task.wait(u4);
        end;

        Debris:AddItem(u10, u3 * 2);
    end);
end;