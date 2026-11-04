 

 

local StarterGui = game:GetService("StarterGui");
local ProximityPromptService = game:GetService("ProximityPromptService");

return {
    new = function(u1) -- Line: 5, Name: new
        -- upvalues: ProximityPromptService (copy), StarterGui (copy)
        local u2 = {
            hidden = false,
            records = {},
            connections = {},
            core = {}
        };
        local PlayerGui = u1:WaitForChild("PlayerGui");

        local function eligible(p3) -- Line: 8
            local v4 = (p3:IsA("ScreenGui") or p3:IsA("BillboardGui") or p3:IsA("SurfaceGui")) and not p3:GetAttribute("CreatorCaptureExempt");

            return v4;
        end;

        local function watch(u5) -- Line: 11
            -- upvalues: u2 (copy)
            if u2.hidden then
                local v6 = (u5:IsA("ScreenGui") or u5:IsA("BillboardGui") or u5:IsA("SurfaceGui")) and not u5:GetAttribute("CreatorCaptureExempt");

                if v6 and not u2.records[u5] then
                    local u7 = {
                        ownWrites = 0,
                        wanted = u5.Enabled
                    };
                    u2.records[u5] = u7;

                    local function suppress() -- Line: 14
                        -- upvalues: u5 (copy), u7 (copy)
                        if u5.Enabled then
                            local v8 = u7;
                            v8.ownWrites = v8.ownWrites + 1;
                            u5.Enabled = false;
                        end;
                    end;

                    u7.connection = u5:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 17
                        -- upvalues: u2 (ref), u5 (copy), u7 (copy)
                        if not u2.hidden then
                            return;
                        end;

                        if u5.Enabled or u7.ownWrites <= 0 then
                            u7.wanted = u5.Enabled;

                            if u5.Enabled then
                                local v9 = u7;
                                v9.ownWrites = v9.ownWrites + 1;
                                u5.Enabled = false;
                            end;

                            return;
                        end;

                        local v10 = u7;
                        v10.ownWrites = v10.ownWrites - 1;
                    end);

                    if u5.Enabled then
                        u7.ownWrites = u7.ownWrites + 1;
                        u5.Enabled = false;
                    end;
                end;
            end;
        end;

        function u2.setHidden(u11, p12) -- Line: 24
            -- upvalues: PlayerGui (copy), watch (copy), ProximityPromptService (ref), StarterGui (ref), u1 (copy)
            if u11.hidden == p12 then
                return;
            end;

            u11.hidden = p12;

            if p12 then
                for _, v in { PlayerGui, workspace } do
                    table.insert(u11.connections, v.DescendantAdded:Connect(watch));

                    for _, descendant in v:GetDescendants() do
                        watch(descendant);
                    end;
                end;

                u11.promptEnabled = ProximityPromptService.Enabled;
                ProximityPromptService.Enabled = false;

                for _, v in Enum.CoreGuiType:GetEnumItems() do
                    if v ~= Enum.CoreGuiType.All then
                        local success, result = pcall(StarterGui.GetCoreGuiEnabled, StarterGui, v);

                        if success then
                            u11.core[v] = result;
                            pcall(StarterGui.SetCoreGuiEnabled, StarterGui, v, false);
                        end;
                    end;
                end;

                local success, result = pcall(StarterGui.GetCore, StarterGui, "TopbarEnabled");
                u11.topbar = success and result or nil;

                if success then
                    pcall(StarterGui.SetCore, StarterGui, "TopbarEnabled", false);
                end;

                local u13 = 0;
                local connections = u11.connections;
                local Heartbeat = game:GetService("RunService").Heartbeat;
                table.insert(connections, Heartbeat:Connect(function(p14) -- Line: 42
                    -- upvalues: u13 (ref), u11 (copy), StarterGui (ref)
                    u13 = u13 + p14;

                    if u13 < 0.25 or not u11.hidden then
                        return;
                    end;

                    u13 = 0;

                    for i in u11.core do
                        local success2, result2 = pcall(StarterGui.GetCoreGuiEnabled, StarterGui, i);

                        if success2 and result2 then
                            u11.core[i] = true;
                            pcall(StarterGui.SetCoreGuiEnabled, StarterGui, i, false);
                        end;
                    end;
                end));
            else
                for _, v in u11.connections do
                    v:Disconnect();
                end;

                table.clear(u11.connections);

                for i, v in u11.records do
                    v.connection:Disconnect();

                    if i.Parent then
                        i.Enabled = v.wanted;
                    end;
                end;

                table.clear(u11.records);

                for i, v in u11.core do
                    pcall(StarterGui.SetCoreGuiEnabled, StarterGui, i, v);
                end;

                table.clear(u11.core);

                if u11.topbar ~= nil then
                    pcall(StarterGui.SetCore, StarterGui, "TopbarEnabled", u11.topbar);
                end;

                if u11.promptEnabled ~= nil then
                    ProximityPromptService.Enabled = u11.promptEnabled;
                end;
            end;

            u1:SetAttribute("CreatorUIHidden", p12 or nil);
        end;

        function u2.destroy(p15) -- Line: 63
            p15:setHidden(false);
        end;

        return u2;
    end
};