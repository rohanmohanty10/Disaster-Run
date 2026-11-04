 
 

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");

return function(p1: userdata, p2: boolean?) -- Line: 4
    -- upvalues: Players (copy), TweenService (copy)
    local u3 = p1:Clone();
    u3.DisplayOrder = 4;
    local u4 = {};
    local u5 = false;
    local u6 = p2 or false;

    for _, child in u3:GetChildren() do
        if child:IsA("Frame") then
            if child.Name == "BG" then
                u5 = true;
            else
                child.Visible = false;
                local v7 = {
                    obj = child,
                    labels = {}
                };

                for _, child2 in child:GetChildren() do
                    if child2:IsA("TextLabel") then
                        child2.Visible = false;
                        v7.labels[tonumber(child2.Name)] = child2;
                    end;
                end;

                u4[tonumber(child.Name)] = v7;
            end;
        end;
    end;

    u3.Parent = Players.LocalPlayer.PlayerGui;
    task.spawn(function() -- Line: 41
        -- upvalues: u4 (copy), u5 (ref), TweenService (ref), u6 (ref), u3 (copy)
        for i, v in u4 do
            v.obj.Visible = true;
            local v8 = v;

            for _, v2 in v.labels do
                v2.Visible = true;
                task.wait(v2:GetAttribute("Delay") or 0.025);
            end;

            task.wait(v8.obj:GetAttribute("Lifetime") or 1);

            if i == #u4 then
                if u5 then
                    if not u6 then
                        u3:Destroy();
                    end;
                else
                    for _, v2 in v8.labels do
                        TweenService:Create(v2, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            TextTransparency = 1
                        }):Play();
                        task.delay(1, function() -- Line: 60
                            -- upvalues: u6 (ref), u3 (ref)
                            if not u6 then
                                u3:Destroy();
                            end;
                        end);
                    end;
                end;
            else
                v8.obj.Visible = false;
            end;
        end;
    end);

    return u3;
end;