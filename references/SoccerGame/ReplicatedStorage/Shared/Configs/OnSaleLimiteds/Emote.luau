  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Assets = ReplicatedStorage.Assets;
local makePlayerModel = require(ReplicatedStorage.Shared.utils.makePlayerModel);
local Emotes = require(ReplicatedStorage.Shared.Emotes.Emotes);

return function(p1: string, p2: any, p3: any) -- Line: 7
    -- upvalues: makePlayerModel (copy), Emotes (copy), Assets (copy)
    return {
        Type = "Emote",
        HeaderOffset = 10,
        Name = p1,
        ProductId = p2,
        GiftProductId = p3,
        Gradient = script.EmoteGradient,

        LoadVisual = function(p4, p5) -- Line: 15, Name: LoadVisual
            -- upvalues: makePlayerModel (ref), Emotes (ref), Assets (ref)
            local u6 = makePlayerModel();
            u6:PivotTo(p5.Origin.CFrame * CFrame.new(0, 0, 0));
            u6.Parent = p5;
            local u7 = Emotes[p4.Name];

            if u7 and (u7.play and (u7.meta and u7.meta.continuousDisplay)) then
                local u8 = u7.play(u6, "VisualWorld");
                u6.Destroying:Once(function() -- Line: 23
                    -- upvalues: u8 (copy)
                    if u8 then
                        u8();
                    end;
                end);
            elseif u7 and u7.play then
                task.spawn(function() -- Line: 29
                    -- upvalues: u6 (copy), u7 (copy)
                    while true do
                        if not u6.Parent then
                            return;
                        end;

                        local v9 = u7.play(u6, "VisualWorld");
                        local v10 = 2;
                        local Humanoid = u6:FindFirstChild("Humanoid");

                        if Humanoid then
                            Humanoid = Humanoid:FindFirstChildOfClass("Animator");
                        end;

                        if Humanoid then
                            for _, v in Humanoid:GetPlayingAnimationTracks() do
                                if v.Length and v.Length > 0 then
                                    v10 = v.Length;
                                    break;
                                end;
                            end;
                        end;

                        task.wait(v10);

                        if v9 then
                            v9();
                        end;
                    end;
                end);
            end;

            if p4.Name == "Eagle Ride" then
                u6:ScaleTo(u6:GetScale() * 0.25);
            end;

            if p4.Name == "My Finest Clown" then
                p5.FinestClownRig2.Humanoid:LoadAnimation(Assets.Emotes[p4.Name .. "C2"]):Play();
            end;
        end
    };
end;