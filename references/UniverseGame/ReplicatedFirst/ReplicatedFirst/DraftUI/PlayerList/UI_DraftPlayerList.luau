  

 

return function(p1) -- Line: 2
    local Parent = script.Parent;
    local PlayerFrame = p1.Assets.PlayerFrame;
    local u2 = p1.Knit.GetService("AbilityDraftService");
    local u3 = {};
    local u4 = {
        Banning = {
            Text = "Waiting for ban",
            Color = Color3.new(1, 0, 0)
        },
        Banned = {
            Text = "Already banned",
            Color = Color3.new(0, 1, 0)
        },
        Picking = {
            Text = "Waiting for pick",
            Color = Color3.new(1, 0, 0)
        },
        Picked = {
            Text = "Already picked",
            Color = Color3.new(0, 1, 0)
        }
    };

    local function AddFrame(p5) -- Line: 31
        -- upvalues: u3 (copy), PlayerFrame (copy), u2 (copy), u4 (copy), Parent (copy)
        if u3[p5] then
            return u3[p5];
        end;

        local u6 = PlayerFrame:Clone();
        u6.DisplayName.Text = p5.DisplayName;
        u6.UserName.Text = "@" .. p5.Name;
        u2:GetStatus(p5):andThen(function(p7) -- Line: 37
            -- upvalues: u4 (ref), u6 (copy)
            local v8 = u4[p7];

            if v8 then
                u6.Status.TextColor3 = v8.Color;
                u6.Status.Text = v8.Text;
            end;
        end):catch(warn);
        u3[p5] = u6;
        u6.Visible = true;
        u6.Parent = Parent;
    end;

    function p1.UpdateStatus(p9, p10) -- Line: 50
        -- upvalues: u3 (copy), u4 (copy), AddFrame (copy)
        local v11 = u3[p9];

        if not (v11 and u4[p10]) then
            if not v11 then
                AddFrame(p9);
            end;

            return;
        end;

        local v12 = u4[p10];
        v11.Status.TextColor3 = v12.Color;
        v11.Status.Text = v12.Text;
    end;

    function p1.UpdateAllStatus() -- Line: 62
        -- upvalues: u3 (copy), u2 (copy), u4 (copy)
        for i, v in pairs(u3) do
            u2:GetStatus(i):andThen(function(p13) -- Line: 64
                -- upvalues: u4 (ref), v (copy)
                local v14 = u4[p13];

                if v14 then
                    v.Status.TextColor3 = v14.Color;
                    v.Status.Text = v14.Text;
                end;
            end):catch(warn);
        end;
    end;

    AddFrame(p1.Player);
    game.Players.PlayerAdded:Connect(AddFrame);

    for _, v in ipairs(game.Players:GetPlayers()) do
        AddFrame(v);
    end;
end;