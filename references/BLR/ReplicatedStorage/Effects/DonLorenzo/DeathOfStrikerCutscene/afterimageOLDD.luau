  

local v1 = {};
local TweenService = game:GetService("TweenService");
game:GetService("Debris");

function v1.new(u2: userdata, u3: number, u4: number, u5, u6: number) -- Line: 6
    -- upvalues: TweenService (copy)
    local u7 = script.r6rig:Clone();
    task.spawn(function() -- Line: 8
        -- upvalues: u2 (copy), u7 (copy), u5 (copy), TweenService (ref), u3 (copy), u6 (copy), u4 (copy)
        for _, descendant in u2:GetDescendants() do
            if descendant:IsA("BasePart") then
                if string.find(descendant.Name, "Arm") or (string.find(descendant.Name, "Leg") or (string.find(descendant.Name, "Torso") or string.find(descendant.Name, "Head") and not descendant.Name == "header")) then
                    u7[string.lower(descendant.Name)].CFrame = descendant.CFrame;
                elseif descendant.Transparency ~= 1 then
                    descendant:Clone().Parent = u7;
                end;

                if descendant.Name == "HumanoidRootPart" then
                    u7.root.CFrame = descendant.CFrame;
                end;
            end;
        end;

        for _, child in u7:GetChildren() do
            local v8;

            if child:IsA("BasePart") then
                child.Transparency = 1;
                child.Material = Enum.Material.Glass;
                child.CanCollide = false;
                child.Anchored = true;
                child.Size = child.Size + Vector3.new(-0.01, -0.01, -0.01);
                v8 = child;

                for _, child2 in child:GetChildren() do
                    if not child2:IsA("SpecialMesh") then
                        child2:Destroy();
                    end;
                end;
            else
                v8 = child;
            end;

            if v8:IsA("MeshPart") then
                script.texture:Clone().Parent = v8;
            end;
        end;

        local Highlight = Instance.new("Highlight");
        Highlight.Parent = u7;
        Highlight.Name = "hl";
        Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
        Highlight.OutlineColor = u5;
        Highlight.FillColor = u5;
        Highlight.OutlineTransparency = 1;
        Highlight.FillTransparency = 1;
        TweenService:Create(Highlight, TweenInfo.new(u3, Enum.EasingStyle.Linear), {
            OutlineTransparency = u6
        }):Play();
        TweenService:Create(Highlight, TweenInfo.new(u3, Enum.EasingStyle.Linear), {
            FillTransparency = u6
        }):Play();
        task.delay(u3, function() -- Line: 52
            -- upvalues: TweenService (ref), Highlight (copy), u4 (ref), u7 (ref)
            TweenService:Create(Highlight, TweenInfo.new(u4, Enum.EasingStyle.Linear), {
                OutlineTransparency = 1.2
            }):Play();
            TweenService:Create(Highlight, TweenInfo.new(u4, Enum.EasingStyle.Linear), {
                FillTransparency = 1.2
            }):Play();
            task.delay(u4, u7.Destroy, u7);
        end);
    end);
    u7.Parent = game.Workspace.Camera;

    return u7;
end;

function v1.fixtopart(u9: userdata, u10: userdata?, u11: number, u12: number?, u13, u14: number) -- Line: 63
    -- upvalues: TweenService (copy)
    if u9 then
        local u15 = nil;
        task.spawn(function() -- Line: 66
            -- upvalues: u15 (ref), u10 (copy), u13 (copy), TweenService (ref), u11 (copy), u14 (copy), u9 (copy), u12 (ref)
            u15 = script.r6rig:Clone();
            u15.Parent = game.Workspace.temp.afterimages;

            for _, descendant in u10:GetDescendants() do
                if descendant:IsA("BasePart") then
                    if string.find(descendant.Name, "Arm") or (string.find(descendant.Name, "Leg") or (string.find(descendant.Name, "Torso") or string.find(descendant.Name, "Head"))) then
                        u15[string.lower(descendant.Name)].CFrame = descendant.CFrame;
                    elseif descendant.Transparency ~= 1 then
                        descendant:Clone().Parent = u15;
                    end;

                    if descendant.Name == "HumanoidRootPart" then
                        u15.root.CFrame = descendant.CFrame;
                    end;
                end;
            end;

            for _, child in u15:GetChildren() do
                local v16;

                if child:IsA("BasePart") then
                    child.Transparency = 1;
                    child.Material = Enum.Material.Glass;
                    child.CanCollide = false;
                    child.Anchored = true;
                    child.Size = child.Size + Vector3.new(-0.01, -0.01, -0.01);
                    v16 = child;

                    for _, child2 in child:GetChildren() do
                        if not child2:IsA("SpecialMesh") then
                            child2:Destroy();
                        end;
                    end;
                else
                    v16 = child;
                end;

                if v16:IsA("MeshPart") then
                    script.texture:Clone().Parent = v16;
                end;
            end;

            local Highlight = Instance.new("Highlight");
            Highlight.Parent = u15;
            Highlight.Name = "hl";
            Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
            Highlight.OutlineColor = u13;
            Highlight.FillColor = u13;
            Highlight.OutlineTransparency = 1;
            Highlight.FillTransparency = 1;
            TweenService:Create(Highlight, TweenInfo.new(u11, Enum.EasingStyle.Linear), {
                OutlineTransparency = u14
            }):Play();
            TweenService:Create(Highlight, TweenInfo.new(u11, Enum.EasingStyle.Linear), {
                FillTransparency = u14
            }):Play();
            local u17 = nil;
            u17 = game:GetService("RunService").RenderStepped:Connect(function() -- Line: 117
                -- upvalues: u15 (ref), u9 (ref), u17 (ref)
                if u15:IsDescendantOf(workspace) and u9:IsDescendantOf(game) then
                    u15:PivotTo(u9.CFrame);

                    return;
                end;

                if u17.Connected then
                    u17:Disconnect();
                end;
            end);
            task.wait(u11);

            if not u12 then
                u12 = 0.35;

                repeat
                    task.wait();
                until u15:GetAttribute("Clear");
            end;

            TweenService:Create(Highlight, TweenInfo.new(u12, Enum.EasingStyle.Linear), {
                OutlineTransparency = 1.2
            }):Play();
            TweenService:Create(Highlight, TweenInfo.new(u12, Enum.EasingStyle.Linear), {
                FillTransparency = 1.2
            }):Play();
            task.wait(u12);

            if u17.Connected then
                u17:Disconnect();
            end;

            u15:Destroy();
        end);

        return u15;
    end;
end;

return v1;