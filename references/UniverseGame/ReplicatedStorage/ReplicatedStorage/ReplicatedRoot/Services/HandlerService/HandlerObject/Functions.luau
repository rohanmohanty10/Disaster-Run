  

 

return {
    Init = function(u1, p2) -- Line: 3, Name: Init
        local Collector = p2.Collector;

        if game:GetService("RunService"):IsServer() then
            function u1.AddClient(u3, p4, p5) -- Line: 6
                local v6 = p5 or {};

                if not v6.Name then
                    v6.Name = p4:GetAttribute("Name") or p4.Name;
                end;

                if p4:IsA("ModuleScript") then
                    if not p4:IsDescendantOf(u3.Root.Client) then
                        local v7 = u3.Root.Client:FindFirstChild(v6.Name);

                        if v7 and not v7:GetAttribute("Removing") then
                            return;
                        end;

                        local v8 = p4:Clone();
                        v8.Name = v6.Name or v8.Name;
                        v8:SetAttribute("Name", v6.Name);
                        v8.Parent = u3.Root.Client;
                    end;

                    return;
                end;

                local function Iterate(p9) -- Line: 13
                    -- upvalues: u3 (copy), Iterate (copy)
                    for _, child in pairs(p9:GetChildren()) do
                        if child:IsA("ModuleScript") then
                            u3:AddClient(child);
                        else
                            Iterate(child);
                        end;
                    end;
                end;

                Iterate(p4);
            end;

            function u1.RemoveClient(p10, u11) -- Line: 42
                if typeof(u11) == "Instance" and (u11:IsDescendantOf(p10.Root.Client) and not u11:GetAttribute("Removing")) then
                    u11:SetAttribute("Removing", true);
                    task.delay(1, function() -- Line: 45
                        -- upvalues: u11 (copy)
                        u11:Destroy();
                    end);
                end;

                for _, descendant in pairs(p10.Root.Client:GetDescendants()) do
                    if descendant:IsA("ModuleScript") and (descendant:GetAttribute("Name") == u11 and not descendant:GetAttribute("Removing")) then
                        descendant:SetAttribute("Removing", true);
                        descendant:Destroy();

                        return;
                    end;
                end;
            end;

            function u1.InitClient(p12) -- Line: 59
                p12.Root.Client:SetAttribute("Init", #p12.Root.Client:GetChildren());
            end;

            function u1.StartClient(p13) -- Line: 63
                p13.Root.Client:SetAttribute("Start", true);
            end;

            return;
        end;

        for _, child in pairs(u1.Root.Client:GetChildren()) do
            if child:IsA("ModuleScript") then
                u1:Add(child);
            end;
        end;

        u1.Root.Client.ChildAdded:Connect(function(p14) -- Line: 73
            -- upvalues: u1 (copy)
            if p14:IsA("ModuleScript") then
                u1:Add(p14);
            end;
        end);
        u1.Root.Client.ChildRemoved:Connect(function(p15) -- Line: 79
            -- upvalues: u1 (copy)
            if p15:IsA("ModuleScript") then
                u1:Remove(p15:GetAttribute("Name") or p15.Name);
            end;
        end);

        local function Start() -- Line: 85
            -- upvalues: u1 (copy)
            if u1.Root.Client:GetAttribute("Start") then
                u1:Start();
            end;
        end;

        if u1.Root.Client:GetAttribute("Start") then
            u1:Start();
        end;

        Collector:Connect(u1.Root.Client:GetAttributeChangedSignal("Start"), Start);
    end
};