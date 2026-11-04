  

local v1 = {};
local RunService = game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
local TweenService = game:GetService("TweenService");
require(game:GetService("ReplicatedStorage").Shared.Essentials);

function v1.SetupCosmetic(u2, p3) -- Line: 7
    -- upvalues: CollectionService (copy), RunService (copy), TweenService (copy)
    local u4 = script.Wheel:Clone();
    local NumberValue = Instance.new("NumberValue");
    local PlayerFromCharacter = game.Players:GetPlayerFromCharacter(u2);
    NumberValue.Value = 0;
    u4.Parent = u2;
    CollectionService:AddTag(u4, (`Cosmetic{p3}`));
    local Descendants = script.AuraGive:GetDescendants();
    local v5 = {};
    local u6 = nil;
    local u7 = nil;
    local u8 = nil;

    for _, v in pairs(Descendants) do
        if v:IsA("ParticleEmitter") == false and v:IsA("Beam") == false then
            if v:IsA("Highlight") then
                local v9 = v:Clone();
                v9.Name = "AuraParticle";
                v9.Parent = u2;
                CollectionService:AddTag(v9, (`Cosmetic{p3}`));
            end;
        elseif not v5[v.Parent] then
            if v:IsA("ParticleEmitter") then
                if v.Parent:IsA("Attachment") then
                    if v.Parent.Parent:IsA("Attachment") then
                        v5[v.Parent] = true;
                        local v10 = v.Parent.Parent:Clone();
                        v10.Name = "AuraParticle";
                        CollectionService:AddTag(v10, (`Cosmetic{p3}`));
                        v10.Parent = u2[v.Parent.Parent.Parent.Name];
                    else
                        v5[v.Parent] = true;
                        local v11 = v.Parent:Clone();
                        v11.Name = "AuraParticle";
                        CollectionService:AddTag(v11, (`Cosmetic{p3}`));
                        v11.Parent = u2[v.Parent.Parent.Name];
                    end;
                else
                    local v12 = v:Clone();
                    v12.Name = "AuraParticle";
                    CollectionService:AddTag(v12, (`Cosmetic{p3}`));
                    v12.Parent = u2[v.Parent.Name];
                end;
            elseif v:IsA("Beam") then
                local v13;

                if v.Parent:IsA("Attachment") then
                    if v.Parent.Parent:IsA("Attachment") then
                        v13 = v.Parent.Parent.Parent.Name;
                    else
                        v13 = v.Parent.Parent.Name;
                    end;
                else
                    v13 = v.Parent.Name;
                end;

                local v14 = v:Clone();
                CollectionService:AddTag(v14, (`Cosmetic{p3}`));
                v14.Name = "AuraParticle";
                local v15 = v.Attachment0:Clone();
                CollectionService:AddTag(v14, (`Cosmetic{p3}`));
                v15.Name = "AuraParticle";
                v15.Parent = u2[v13];
                local v16 = v.Attachment1:Clone();
                v16.Name = "AuraParticle";
                CollectionService:AddTag(v14, (`Cosmetic{p3}`));
                v16.Parent = u2[v13];
                v14.Attachment0 = v15;
                v14.Attachment1 = v16;
                v14.Parent = u2[v13];
            end;
        end;
    end;

    CollectionService:AddTag(NumberValue, (`Cosmetic{p3}`));
    u7 = RunService.RenderStepped:Connect(function(p17) -- Line: 99
        -- upvalues: PlayerFromCharacter (copy), u8 (ref), TweenService (ref), NumberValue (copy), u4 (copy), u6 (ref), u2 (copy), u7 (ref)
        if PlayerFromCharacter and (PlayerFromCharacter:FindFirstChild("GameStats") and (PlayerFromCharacter.GameStats:FindFirstChild("Goals") and (PlayerFromCharacter.GameStats.Goals.Value > 0 and PlayerFromCharacter.GameStats.Goals.Value ~= u8))) then
            task.delay(1, function() -- Line: 102
                -- upvalues: TweenService (ref), NumberValue (ref), u4 (ref)
                TweenService:Create(NumberValue, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                    Value = NumberValue.Value + 60
                }):Play();
                local v18 = u4:FindFirstChildOfClass("Sound");

                if v18 then
                    v18.TimePosition = 0;
                    v18:Play();
                end;
            end);
            u8 = PlayerFromCharacter.GameStats.Goals.Value;
        end;

        if PlayerFromCharacter and (PlayerFromCharacter:FindFirstChild("GameStats") and (PlayerFromCharacter.GameStats:FindFirstChild("Steals") and (PlayerFromCharacter.GameStats.Steals.Value > 0 and PlayerFromCharacter.GameStats.Steals.Value ~= u6))) then
            task.delay(1, function() -- Line: 116
                -- upvalues: TweenService (ref), NumberValue (ref), u4 (ref)
                TweenService:Create(NumberValue, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                    Value = NumberValue.Value + 60
                }):Play();
                local v19 = u4:FindFirstChildOfClass("Sound");

                if v19 then
                    v19.TimePosition = 0;
                    v19:Play();
                end;
            end);
            u6 = PlayerFromCharacter.GameStats.Steals.Value;
        end;

        if u2 and u2.Parent then
            u4:PivotTo(u2.Torso:GetPivot() * CFrame.new(0, 0.5, 1.2) * CFrame.Angles(1.5707963267948966, math.rad(NumberValue.Value), 0));

            return;
        end;

        u7:Disconnect();
        u4:Destroy();
    end);
end;

return v1;