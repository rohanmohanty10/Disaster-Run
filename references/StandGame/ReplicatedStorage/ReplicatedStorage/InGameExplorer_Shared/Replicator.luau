 

 

game:GetService("HttpService");
game:GetService("RunService");
local u1 = {
    "Workspace",
    "Players",
    "Lighting",
    "MaterialService",
    "ReplicatedFirst",
    "ReplicatedStorage",
    "ServerScriptService",
    "ServerStorage",
    "StarterGui",
    "StarterPack",
    "StarterPlayer",
    "SoundService"
};
local u2 = {
    "Workspace",
    "Players",
    "CoreGui",
    "Lighting",
    "MaterialService",
    "PluginGuiService",
    "ReplicatedFirst",
    "ReplicatedStorage",
    "RobloxPluginGuiService",
    "StarterGui",
    "StarterPack",
    "StarterPlayer",
    "Teams",
    "SoundService",
    "TextChatService"
};
local u3 = {};
u3.__index = u3;
function u3.new(p4, p5, p6, p7) --[[ Line: 39 ]]
    -- upvalues: u3 (copy)
    return setmetatable({
        RemoteEvent = p4,
        RemoteFunction = p5,
        ListeningAdmins = {},
        Classes = p6,
        RepShared = p7
    }, u3);
end;
function u3.GetViewlist(p8) --[[ Line: 49 ]]
    -- upvalues: u1 (copy), u2 (copy)
    return p8.Server and u1 or u2;
end;
function u3.FireClient(p9, p10, ...) --[[ Line: 53 ]]
    if p9.Server then
        p9.RemoteEvent:FireClient(p10, ...);
    else
        p9.RemoteEvent:FireServer("FireClient", p10, ...);
    end;
end;
function u3.Cleanup(_) --[[ Line: 60 ]] end;
function u3.InitInstance(u11, u12, u13) --[[ Line: 68 ]]
    local l__IdCounter__1 = u12.IdCounter;
    u12.IdCounter = u12.IdCounter + 1;
    local u14 = {
        Listening = false,
        Instance = u13,
        Id = l__IdCounter__1,
        Name = u13.Name,
        ClassName = u13.ClassName,
        Connections = {},
        Children = u13:GetChildren(),
        ChildIndices = {}
    };
    if u13 == game then
        for v15 = #u14.Children, 1, -1 do
            local v16 = u14.Children[v15];
            if not table.find(u11:GetViewlist(), v16.ClassName) then
                table.remove(u14.Children, v15);
            end;
        end;
    end;
    for v17, v18 in u14.Children do
        u14.ChildIndices[v18] = v17;
    end;
    u12.InstancesById[u14.Id] = u14;
    u12.InstancesByObject[u14.Instance] = u14;
    u14.Connections.NameChanged = u13:GetPropertyChangedSignal("Name"):Connect(function() --[[ Line: 101 ]]
        -- upvalues: u14 (copy), u13 (copy), u11 (copy), u12 (copy)
        u14.Name = u13.Name;
        u11:FireClient(u12.Admin, "Update", u14.Id, {
            Name = u14.Name
        });
    end);
    u14.Connections.ChildAdded = u13.ChildAdded:Connect(function(p19) --[[ Line: 106 ]]
        -- upvalues: u13 (copy), u11 (copy), u14 (copy), u12 (copy)
        if u13 == game and not table.find(u11:GetViewlist(), p19.ClassName) then
        else
            local v20 = #u14.Children + 1;
            u14.Children[v20] = p19;
            u14.ChildIndices[p19] = v20;
            if u14.Listening then
                local v21 = u11:InitInstance(u12, p19);
                u11:FireClient(u12.Admin, "Init", u14.Id, {
                    Id = v21.Id,
                    Name = v21.Name,
                    ClassName = v21.ClassName,
                    HasChildren = #v21.Children > 0
                });
            else
                if #u14.Children == 1 then
                    u11:FireClient(u12.Admin, "Update", u14.Id, {
                        HasChildren = true
                    });
                end;
            end;
        end;
    end);
    u14.Connections.ChildRemoved = u13.ChildRemoved:Connect(function(p22) --[[ Line: 133 ]]
        -- upvalues: u14 (copy), u12 (copy), u11 (copy)
        local v23 = u14.ChildIndices[p22];
        if v23 then
            local v24 = #u14.Children;
            local v25 = u14.Children[v24];
            u14.Children[v23] = v25;
            u14.ChildIndices[v25] = v23;
            u14.Children[v24] = nil;
            u14.ChildIndices[p22] = nil;
            if u14.Listening then
                u11:ClearInstance(u12, (assert(u12.InstancesByObject[p22])));
            else
                if #u14.Children == 0 then
                    u11:FireClient(u12.Admin, "Update", u14.Id, {
                        HasChildren = false
                    });
                end;
            end;
        end;
    end);
    return u14;
end;
function u3.InitInstanceListeners(p26, p27, p28) --[[ Line: 161 ]]
    assert(not p28.Listening);
    p28.Listening = true;
    local v29 = {};
    for _, v30 in p28.Children do
        local v31 = p26:InitInstance(p27, v30);
        table.insert(v29, {
            Id = v31.Id,
            Name = v31.Name,
            ClassName = v31.ClassName,
            HasChildren = #v31.Children > 0
        });
    end;
    p26:FireClient(p27.Admin, "Update", p28.Id, {
        Children = v29
    });
end;
function u3.StartListening(p32, p33, p34) --[[ Line: 184 ]]
    local v35 = p32.ListeningAdmins[p33];
    if not v35 then
        assert(not p34);
        v35 = {
            SelectedInstance = nil,
            IdCounter = 0,
            InstancesById = {},
            InstancesByObject = {},
            Admin = p33
        };
        p32.ListeningAdmins[p33] = v35;
    end;
    if p34 then
        p32:InitInstanceListeners(v35, (assert(v35.InstancesById[p34])));
    else
        assert(not v35.Root);
        local v36 = p32:InitInstance(v35, game);
        v35.Root = v36;
        p32:FireClient(v35.Admin, "Init", nil, {
            Id = v36.Id,
            Name = v36.Name,
            ClassName = v36.ClassName,
            HasChildren = #v36.Children > 0
        });
    end;
end;
function u3.StopListening(p37, p38, p39) --[[ Line: 227 ]]
    local v40 = p37.ListeningAdmins[p38];
    if v40 then
        p37:StopSelectingInstance(p38);
        if p39 == nil then
            p37.ListeningAdmins[p38] = nil;
            for _, v41 in v40.InstancesById do
                for _, v42 in v41.Connections do
                    v42:Disconnect();
                end;
            end;
            p37:FireClient(v40.Admin, "Remove", nil);
        else
            p37:ClearInstanceListeners(v40, (assert(v40.InstancesById[p39])));
        end;
    end;
end;
function u3.StopSelectingInstance(p43, p44) --[[ Line: 251 ]]
    local v45 = p43.ListeningAdmins[p44];
    if v45 then
        local l__SelectedInstanceMaid__2 = v45.SelectedInstanceMaid;
        if l__SelectedInstanceMaid__2 then
            l__SelectedInstanceMaid__2:Cleanup();
        end;
        v45.SelectedInstance = nil;
    end;
end;
function u3.ClearInstance(p46, p47, p48, p49) --[[ Line: 265 ]]
    if p48.Listening then
        p46:ClearInstanceListeners(p47, p48, true);
    end;
    for _, v50 in p48.Connections do
        v50:Disconnect();
    end;
    p47.InstancesById[p48.Id] = nil;
    p47.InstancesByObject[p48.Id] = nil;
    if not p49 then
        p46:FireClient(p47.Admin, "Remove", p48.Id);
    end;
end;
function u3.ClearInstanceListeners(p51, p52, p53, p54) --[[ Line: 285 ]]
    assert(p53.Listening);
    p53.Listening = false;
    for _, v55 in p53.Children do
        p51:ClearInstance(p52, assert(p52.InstancesByObject[v55]), true);
    end;
    if not p54 then
        p51:FireClient(p52.Admin, "Update", p53.Id, {
            HasChildren = #p53.Children > 0
        });
    end;
end;
function u3.SelectInstance(p56, p57, p58) --[[ Line: 302 ]]
    local v59 = p58 and p56.ListeningAdmins[p57];
    if v59 then
        p56:StopSelectingInstance(p57);
        local v60 = assert(v59.InstancesById[p58]);
        if not v60 then
            return;
        end;
        local l__Instance__3 = v60.Instance;
        local v61 = {};
        local v62 = p56.Classes[v60.ClassName];
        if not v62 then
            return;
        end;
        for _, v63 in v62.Categorized_Properties do
            for _, v64 in v63.list do
                local l__propertyName__4 = v64.propertyName;
                local v65, v66 = pcall(function() --[[ Line: 328 ]]
                    -- upvalues: l__Instance__3 (copy), l__propertyName__4 (copy)
                    return l__Instance__3[l__propertyName__4];
                end);
                if v65 then
                    local _ = v64.valueType;
                    local l__tags__5 = v64.tags;
                    if not (l__tags__5 and (l__tags__5.Deprecated or (l__tags__5.NotScriptable or l__tags__5.Hidden))) then
                        v61[l__propertyName__4] = v66;
                    end;
                end;
            end;
        end;
        v61.AttributesList = l__Instance__3:GetAttributes();
        local v67, v68 = p56.RepShared:Open(p57, l__Instance__3, v62, p56.RemoteEvent);
        v59.SelectedInstance = v67;
        v59.SelectedInstanceMaid = v68;
        v61.FullName = l__Instance__3:GetFullName();
        p56:FireClient(p57, "OpenProperties", v60.Id, v61);
    end;
end;
function u3.RequestPropertyChange(u69, p70, u71, u72) --[[ Line: 364 ]]
    local v73 = u69.ListeningAdmins[p70];
    if v73 then
        local l__SelectedInstance__6 = v73.SelectedInstance;
        if not l__SelectedInstance__6 then
            return;
        end;
        if not u71 or u72 == nil then
            return;
        end;
        task.spawn(function() --[[ Line: 375 ]]
            -- upvalues: u69 (copy), u71 (copy), l__SelectedInstance__6 (copy), u72 (copy)
            local v74 = u69.RepShared:FindFromPath(u71, l__SelectedInstance__6);
            if v74 and v74.SetValue then
                v74.SetValue(u72);
            end;
        end);
    end;
end;
return u3;