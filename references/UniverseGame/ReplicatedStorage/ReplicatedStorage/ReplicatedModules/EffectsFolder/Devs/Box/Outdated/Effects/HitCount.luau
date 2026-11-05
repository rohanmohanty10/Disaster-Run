  

 

local TweenService = game:GetService("TweenService");
local u1 = game:GetService("ReplicatedStorage")["Client Assets"];
local u2 = {};
local u3 = {};
local u4 = {};

return function(u5, p6) -- Line: 7
    -- upvalues: u1 (copy), u2 (copy), u3 (copy), TweenService (copy), u4 (copy)
    local u7;

    if u5.PlayerGui:FindFirstChild("HitCounter") then
        u7 = u5.PlayerGui.HitCounter;
    else
        u7 = u1.HitCounter:Clone();
        u7.Parent = u5.PlayerGui;
    end;

    local Hits = u7.Hits;
    local Count = u7.Count;
    local Count2 = u7.Count2;

    if not u2[u5] then
        u2[u5] = 2;
    end;

    if not u3[u5] then
        u3[u5] = 0;
    end;

    local function TweenUI() -- Line: 31
        -- upvalues: Count (copy), TweenService (ref)
        Count.Position = UDim2.new(0.075, 0, 0.425, 0);
        TweenService:Create(Count, TweenInfo.new(0.2), {
            TextTransparency = 0.45
        }):Play();
        TweenService:Create(Count, TweenInfo.new(0.2), {
            Position = UDim2.new(0.075, 0, 0.435, 0)
        }):Play();
        coroutine.wrap(function() -- Line: 37
            -- upvalues: TweenService (ref), Count (ref)
            task.wait(0.2);
            TweenService:Create(Count, TweenInfo.new(0.2), {
                TextTransparency = 0
            }):Play();
        end)();
    end;

    if u4[u5] then
        u2[u5] = 2;

        if Hits.TextTransparency > 0 then
            Hits.TextTransparency = 0;
        end;

        local v8 = Count.Text + 1;

        if v8 > 9 then
            v8 = 0;
            u3[u5] = u3[u5] + 1;

            if Count2.TextTransparency > 0 then
                Count2.TextTransparency = 0;
            end;
        end;

        u4[u5] = v8;
        Count2.Text = u3[u5];
        Count.Text = u4[u5];
        TweenUI();
    else
        u4[u5] = 0;

        if Hits.TextTransparency > 0 then
            Hits.TextTransparency = 0;
        end;

        u7.Enabled = true;
        Count.Text = p6;
        task.wait(0.5);
        coroutine.wrap(function() -- Line: 57
            -- upvalues: u2 (ref), u5 (copy)
            task.wait(0.05);

            while u2[u5] ~= nil and (u5.Character.Humanoid.Health > 0 and u2[u5] > 0) do
                u2[u5] = u2[u5] - 0.05;
                task.wait(0.05);
            end;
        end)();
        coroutine.wrap(function() -- Line: 69
            -- upvalues: u2 (ref), u5 (copy), u4 (ref), u3 (ref), u7 (ref), TweenService (ref), Hits (copy), Count (copy), Count2 (copy)
            repeat
                task.wait();
            until u2[u5] <= 0;

            u2[u5] = nil;
            u4[u5] = nil;
            u3[u5] = nil;
            u7.Name = "InvalidHitCounterUI";
            TweenService:Create(Hits, TweenInfo.new(0.2), {
                TextTransparency = 1
            }):Play();
            TweenService:Create(Count, TweenInfo.new(0.2), {
                TextTransparency = 1
            }):Play();
            TweenService:Create(Count2, TweenInfo.new(0.2), {
                TextTransparency = 1
            }):Play();
            coroutine.wrap(function() -- Line: 82
                -- upvalues: u7 (ref)
                task.wait(0.2);
                u7:Destroy();
            end)();
        end)();
    end;
end;