 

 

local u1 = {
    PropertyChanges = {}
};
local l__RunService__1 = game:GetService("RunService");
local u2 = l__RunService__1:IsServer();
local l__Signal__2 = require(script.Signal);
local l__Maid__3 = require(script.Maid);
local u3, _ = unpack(require(script.DataConverter));
local u4 = {
    "PrivateServerOwnerId",
    "PrivateServerId",
    "VIPServerId",
    "VIPServerOwnerId"
};
local function u9(p5, ...) --[[ Line: 19 ]]
    -- upvalues: u9 (copy)
    for _, v6 in pairs({ ... }) do
        if type(v6) == "table" then
            for v7, v8 in pairs(v6) do
                if type(v8) == "table" then
                    if type(p5[v7]) ~= "table" then
                        p5[v7] = {};
                    end;
                    u9(p5[v7], v8);
                else
                    p5[v7] = v8;
                end;
            end;
        end;
    end;
    return p5;
end;
function u1.FindFromPath(_, p10, p11) --[[ Line: 43 ]]
    local v12 = 1;
    local v13 = p10[v12];
    local v14 = nil;
    while p11.Children do
        local v15 = nil;
        for _, v16 in p11.Children do
            if v16.Name == v13 then
                v15 = true;
                if v12 == #p10 then
                    v14 = v16;
                    p11 = v14;
                    local v17 = v14;
                    v14 = p11;
                    v17 = p11;
                else
                    v12 = v12 + 1;
                    v13 = p10[v12];
                    p11 = v16;
                end;
                break;
            end;
        end;
        if not v15 then
            break;
        end;
    end;
    return v14;
end;
local u33 = {
    Vector2 = {
        {
            Name = "X",
            ValueType = "float",
            ValueFn = function(p18) --[[ Name: ValueFn, Line 78 ]]
                return p18.Value.X;
            end,
            SetValueFn = function(p19, p20) --[[ Name: SetValueFn, Line 81 ]]
                if p20.SetValue then
                    p20.SetValue(Vector2.new(p19, p20.Value.Y));
                end;
            end
        },
        {
            Name = "Y",
            ValueType = "float",
            ValueFn = function(p21) --[[ Name: ValueFn, Line 88 ]]
                return p21.Value.Y;
            end,
            SetValueFn = function(p22, p23) --[[ Name: SetValueFn, Line 91 ]]
                if p23.SetValue then
                    p23.SetValue(Vector2.new(p23.Value.X, p22));
                end;
            end
        }
    },
    Vector3 = {
        {
            Name = "X",
            ValueType = "float",
            ValueFn = function(p24) --[[ Name: ValueFn, Line 101 ]]
                return p24.Value.X;
            end,
            SetValueFn = function(p25, p26) --[[ Name: SetValueFn, Line 104 ]]
                if p26.SetValue then
                    p26.SetValue((Vector3.new(p25, p26.Value.Y, p26.Value.Z)));
                end;
            end
        },
        {
            Name = "Y",
            ValueType = "float",
            ValueFn = function(p27) --[[ Name: ValueFn, Line 111 ]]
                return p27.Value.Y;
            end,
            SetValueFn = function(p28, p29) --[[ Name: SetValueFn, Line 114 ]]
                if p29.SetValue then
                    p29.SetValue((Vector3.new(p29.Value.X, p28, p29.Value.Z)));
                end;
            end
        },
        {
            Name = "Z",
            ValueType = "float",
            ValueFn = function(p30) --[[ Name: ValueFn, Line 121 ]]
                return p30.Value.Z;
            end,
            SetValueFn = function(p31, p32) --[[ Name: SetValueFn, Line 124 ]]
                if p32.SetValue then
                    p32.SetValue((Vector3.new(p32.Value.X, p32.Value.Y, p31)));
                end;
            end
        }
    }
};
u33.CFrame = {
    {
        Name = "Position",
        ValueType = "Vector3",
        ValueFn = function(p34) --[[ Name: ValueFn, Line 134 ]]
            return p34.Value.Position;
        end,
        SetValueFn = function(p35, p36) --[[ Name: SetValueFn, Line 137 ]]
            local v37 = p36.Value - p36.Value.Position;
            local v38 = CFrame.new(p35) * v37;
            p36.SetValue(v38);
        end,
        Children = u33.Vector3
    },
    {
        Name = "Orientation",
        ValueType = "Vector3",
        ValueFn = function(p39) --[[ Name: ValueFn, Line 146 ]]
            local v40, v41, v42 = p39.Value:toEulerAnglesYXZ();
            local v43 = math.deg(v40);
            local v44 = math.deg(v41);
            local v45 = math.deg(v42);
            return Vector3.new(v43, v44, v45);
        end,
        SetValueFn = function(p46, p47) --[[ Name: SetValueFn, Line 150 ]]
            local l__Position__4 = p47.Value.Position;
            local l__X__5 = p46.X;
            local l__Y__6 = p46.Y;
            local l__Z__7 = p46.Z;
            local v48 = math.rad(l__X__5);
            local v49 = math.rad(l__Y__6);
            local v50 = math.rad(l__Z__7);
            local v51 = CFrame.fromOrientation(v48, v49, v50);
            local v52 = CFrame.new(l__Position__4) * v51;
            p47.SetValue(v52);
        end,
        Children = u33.Vector3
    }
};
function u1.Open(u53, u54, u55, p56, u57, u58) --[[ Line: 163 ]]
    -- upvalues: u2 (copy), l__Maid__3 (copy), u9 (copy), u4 (copy), u33 (copy), l__Signal__2 (copy), u3 (copy), u1 (copy), l__RunService__1 (copy)
    local u59 = not u2;
    local u60 = l__Maid__3.new();
    if p56 then
        local v61 = u9({}, p56);
        local u62 = {};
        local v63 = {};
        local function v84(p64) --[[ Line: 178 ]]
            -- upvalues: u55 (copy), u59 (copy), u58 (copy), u4 (ref), u33 (ref), u9 (ref), l__Signal__2 (ref), u60 (copy), u62 (copy)
            local v65 = {};
            for _, v66 in p64 do
                local l__propertyName__8 = v66.propertyName;
                local l__tags__9 = v66.tags;
                local v67, v68, v69, v70, u71, v72, v73, u74;
                if v66.isAttribute then
                    v67 = v66.currentValue;
                    v68 = v66.valueType;
                    if v66.isAttribute then
                        v69 = nil;
                    else
                        v70, v69 = pcall(function() --[[ Line: 221 ]] end);
                        if u58 then
                            v69 = false;
                        end;
                    end;
                    u71 = {
                        isAttribute = v66.isAttribute,
                        Name = l__propertyName__8,
                        ValueType = v68
                    };
                    if v69 or l__tags__9 and (l__tags__9.NotScriptable or l__tags__9.Hidden) then
                        u71.ReadOnly = true;
                    end;
                    if l__tags__9 and l__tags__9.ReadOnly then
                        u71.ReadOnly = true;
                    end;
                    u71.Value = v67;
                    v72 = u33[v68];
                    if v72 then
                        v73 = u9({}, v72);
                        u74 = function(p80) --[[ Name: rec, Line 258 ]]
                            -- upvalues: u74 (copy)
                            if p80.Children then
                                for _, v81 in p80.Children do
                                    v81.NotInstanceProp = true;
                                    u74(v81);
                                end;
                            end;
                        end;
                        for _, v82 in v73 do
                            v82.NotInstanceProp = true;
                            if v82.Children then
                                for _, v83 in v82.Children do
                                    v83.NotInstanceProp = true;
                                    u74(v83);
                                end;
                            end;
                        end;
                        u71.Children = v73;
                    end;
                    u71.ValueChanged = l__Signal__2.new();
                    u60:Add(function() --[[ Line: 275 ]]
                        -- upvalues: u71 (copy)
                        u71.ValueChanged:Destroy();
                    end);
                    table.insert(v65, u71);
                    table.insert(u62, {
                        u55,
                        u71,
                        l__propertyName__8,
                        v67,
                        u71.ValueChanged
                    });
                end;
                local v79;
                v79, v67 = pcall(function() --[[ Line: 194 ]]
                    -- upvalues: u55 (ref), l__propertyName__8 (copy)
                    return u55[l__propertyName__8];
                end);
                if v79 and (not u59 or (u58 or not table.find(u4, l__propertyName__8))) and not (l__tags__9 and l__tags__9.Deprecated) then
                    v68 = v66.valueType;
                    if v66.isAttribute then
                        v69 = nil;
                    else
                        v70, v69 = pcall(function() --[[ Line: 221 ]] end);
                        if u58 then
                            v69 = false;
                        end;
                    end;
                    u71 = {
                        isAttribute = v66.isAttribute,
                        Name = l__propertyName__8,
                        ValueType = v68
                    };
                    if v69 or l__tags__9 and (l__tags__9.NotScriptable or l__tags__9.Hidden) then
                        u71.ReadOnly = true;
                    end;
                    if l__tags__9 and l__tags__9.ReadOnly then
                        u71.ReadOnly = true;
                    end;
                    u71.Value = v67;
                    v72 = u33[v68];
                    if v72 then
                        v73 = u9({}, v72);
                        u74 = function(p80) --[[ Name: rec, Line 258 ]]
                            -- upvalues: u74 (copy)
                            if p80.Children then
                                for _, v81 in p80.Children do
                                    v81.NotInstanceProp = true;
                                    u74(v81);
                                end;
                            end;
                        end;
                        for _, v82 in v73 do
                            v82.NotInstanceProp = true;
                            if v82.Children then
                                for _, v83 in v82.Children do
                                    v83.NotInstanceProp = true;
                                    u74(v83);
                                end;
                            end;
                        end;
                        u71.Children = v73;
                    end;
                    u71.ValueChanged = l__Signal__2.new();
                    u60:Add(function() --[[ Line: 275 ]]
                        -- upvalues: u71 (copy)
                        u71.ValueChanged:Destroy();
                    end);
                    table.insert(v65, u71);
                    table.insert(u62, {
                        u55,
                        u71,
                        l__propertyName__8,
                        v67,
                        u71.ValueChanged
                    });
                end;
            end;
            return v65;
        end;
        local v85;
        if typeof(u55) == "table" then
            local l__AttributesList__10 = u55.AttributesList;
            function u55.GetAttribute(_, p86) --[[ Line: 289 ]]
                -- upvalues: l__AttributesList__10 (ref)
                return l__AttributesList__10[p86];
            end;
            function u55.GetFullName(_) --[[ Line: 292 ]]
                -- upvalues: u55 (copy)
                return u55.FullName;
            end;
            v85 = l__AttributesList__10;
        else
            v85 = u55:GetAttributes();
        end;
        local v87 = {
            name = "Attributes",
            list = {}
        };
        for v88, v89 in v85 do
            local v90 = {
                isAttribute = true,
                propertyName = v88,
                valueType = typeof(v89),
                currentValue = v89
            };
            table.insert(v87.list, v90);
        end;
        table.insert(v61.Categorized_Properties, v87);
        for _, v91 in v61.Categorized_Properties do
            local l__name__11 = v91.name;
            local l__list__12 = v91.list;
            table.sort(l__list__12, function(p92, p93) --[[ Line: 313 ]]
                return p92.propertyName < p93.propertyName;
            end);
            local v94 = {
                IsRoot = true,
                Name = l__name__11,
                Children = v84(l__list__12),
                IsCollapsed = false
            };
            if v94.Children and #v94.Children > 0 then
                table.insert(v63, v94);
            end;
        end;
        local function u99(p95) --[[ Line: 326 ]]
            local v96 = { p95.Name };
            while true do
                local l__Parent__13 = p95.Parent;
                if p95 and not p95.Name or not p95 then
                    break;
                end;
                table.insert(v96, l__Parent__13.Name);
                p95 = l__Parent__13;
            end;
            local v97 = {};
            for v98 = #v96, 1, -1 do
                table.insert(v97, v96[v98]);
            end;
            return v97;
        end;
        local function u110(u100) --[[ Line: 348 ]]
            -- upvalues: u3 (ref), u55 (copy), u1 (ref), u58 (copy), u99 (copy), u57 (copy), u53 (copy), l__Signal__2 (ref), u60 (copy), u110 (copy)
            function u100.SetValue(u101, p102) --[[ Line: 350 ]]
                -- upvalues: u100 (copy), u3 (ref), u55 (ref), u1 (ref), u58 (ref), u99 (ref), u57 (ref), u53 (ref)
                local v103 = not u100.NotInstanceProp and u3(u101);
                if v103 then
                    local v104 = u55:GetFullName();
                    local v105 = u1.PropertyChanges[v104];
                    if not v105 then
                        v105 = {
                            properties = {},
                            attributes = {}
                        };
                        u1.PropertyChanges[v104] = v105;
                    end;
                    local l__properties__14 = v105.properties;
                    if u100.isAttribute then
                        l__properties__14 = v105.attributes;
                    end;
                    l__properties__14[u100.Name] = v103;
                end;
                local l__isAttribute__15 = u100.isAttribute;
                if u58 then
                    local v106 = u99(u100);
                    if l__isAttribute__15 then
                        u57:FireServer("RequestAttributeChange", v106, u101);
                    else
                        u57:FireServer("RequestPropertyChange", v106, u101);
                    end;
                else
                    if u100.NotInstanceProp then
                        if u100.SetValueFn then
                            u100.SetValueFn(u101, u100.Parent);
                        end;
                    else
                        local v107, v108 = pcall(function() --[[ Line: 382 ]]
                            -- upvalues: l__isAttribute__15 (copy), u55 (ref), u100 (ref), u101 (copy)
                            if l__isAttribute__15 then
                                u55:SetAttribute(u100.Name, u101);
                            else
                                u55[u100.Name] = u101;
                            end;
                            u100.Value = u101;
                        end);
                        if not v107 then
                            warn(v108);
                        end;
                    end;
                    if p102 then
                        u53:Open(u55);
                    end;
                end;
            end;
            if u100.ValueFn and (u100.Parent and u100.Parent.Value) then
                u100.ValueChanged = l__Signal__2.new();
                u60:Add(function() --[[ Line: 408 ]]
                    -- upvalues: u100 (copy)
                    u100.ValueChanged:Destroy();
                end);
                u100.Value = u100.ValueFn(u100.Parent);
            end;
            if u100.Children then
                for _, v109 in u100.Children do
                    if u100.ReadOnly == true then
                        v109.ReadOnly = true;
                    end;
                    v109.Parent = u100;
                    u110(v109);
                end;
            end;
        end;
        u60:Add(l__RunService__1.Heartbeat:Connect(function() --[[ Line: 427 ]]
            -- upvalues: u62 (copy), u53 (copy), u2 (ref), u57 (copy), u54 (copy), u99 (copy)
            for _, v111 in u62 do
                local v112, v113, v114, v115, v116 = unpack(v111);
                local v117;
                if v113.isAttribute then
                    v117 = v112:GetAttribute(v114);
                else
                    v117 = v112[v114];
                end;
                if v117 ~= v115 then
                    v113.Value = v117;
                    v116:Fire(v117);
                    u53:updateChildren(v113);
                    if u2 then
                        u57:FireClient(u54, "TreeChangedValue", u99(v113), v117);
                    end;
                end;
                v111[4] = v117;
            end;
        end));
        local v118 = {
            IsCollapsed = false,
            Children = v63
        };
        u110(v118);
        return v118, u60;
    end;
    warn("Error - No Class Info - ", u55);
end;
function u1.updateChildren(p119, p120) --[[ Line: 459 ]]
    if p120.Children then
        for _, v121 in p120.Children do
            if v121.ValueFn then
                local v122 = v121.ValueFn(p120);
                v121.Value = v122;
                if v121.ValueChanged then
                    v121.ValueChanged:Fire(v122);
                end;
                p119:updateChildren(v121);
            end;
        end;
    end;
end;
return u1;