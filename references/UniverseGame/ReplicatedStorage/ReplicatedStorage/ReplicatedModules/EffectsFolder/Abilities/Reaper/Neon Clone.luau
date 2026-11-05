  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Trove = require(PathShortcuts.KnitPath.Trove);
local u1 = game.ReplicatedStorage["Client Assets"];
local TweenService = game:GetService("TweenService");
local _ = game.Players.LocalPlayer;

local function tweendeb(p2, p3) -- Line: 10
    p2:Play();
    p2.Completed:Wait();

    if p3 then
        p3:Destroy();
    end;

    return true;
end;

return function(p4, p5) -- Line: 17
    -- upvalues: Trove (copy), u1 (copy), TweenService (copy)
    if not (p4 and p4:IsDescendantOf(workspace)) then
        return;
    end;

    local v6 = Trove.new();
    local clone = u1.Umbra:FindFirstChild("clone");
    local TweenData = p5.TweenData;
    local TweenProperties = p5.TweenProperties;
    local Start = TweenData.Start;
    local End = TweenData.End;
    local Start2 = TweenProperties.Start;
    local End2 = TweenProperties.End;
    local u7;

    if Start then
        u7 = TweenInfo.new(unpack(Start));
    else
        u7 = Start;
    end;

    local u8;

    if End then
        u8 = TweenInfo.new(unpack(End));
    else
        u8 = End;
    end;

    local function find(p9, p10) -- Line: 31
        for _, child in ipairs(p9:GetChildren()) do
            if (child.Name == p10 or child.Name:find(p10)) and child:IsA("BasePart") then
                return child;
            end;
        end;
    end;

    local v11 = 0;

    if p5.Stand then
        p4 = p4:FindFirstChild("Stand") or p4;
    end;

    if p5.StartDelay then
        task.wait(p5.StartDelay);
    end;

    local v12 = (p5.FrameDelay or 0) / 60;

    while v11 <= p5.Duration do
        local v13 = clone:Clone();
        v13.Parent = workspace.Effects;
        task.delay(5, v13.Destroy, v13);

        for _, child in ipairs(v13:GetChildren()) do
            local v14 = find(p4, child.Name);

            if v14 then
                child.CFrame = v14.CFrame;

                if Start then
                    task.spawn(function() -- Line: 58
                        -- upvalues: TweenService (ref), child (copy), u7 (copy), Start2 (copy), End (copy), u8 (copy), End2 (copy)
                        local v15 = TweenService:Create(child, u7, Start2);
                        v15:Play();
                        v15.Completed:Wait();

                        if End then
                            local v16 = TweenService:Create(child, u8, End2);
                            local v17 = child;
                            v16:Play();
                            v16.Completed:Wait();

                            if v17 then
                                v17:Destroy();
                            end;
                        else
                            child:Destroy();
                        end;
                    end);
                else
                    for i, v in pairs(Start2) do
                        child[i] = v;
                    end;

                    task.spawn(function() -- Line: 72
                        -- upvalues: End (copy), TweenService (ref), child (copy), u8 (copy), End2 (copy)
                        if End then
                            local v18 = TweenService:Create(child, u8, End2);
                            local v19 = child;
                            v18:Play();
                            v18.Completed:Wait();

                            if v19 then
                                v19:Destroy();
                            end;
                        else
                            child:Destroy();
                        end;
                    end);
                end;
            end;
        end;

        v11 = v11 + task.wait(v12);
    end;

    v6:Destroy();
end;