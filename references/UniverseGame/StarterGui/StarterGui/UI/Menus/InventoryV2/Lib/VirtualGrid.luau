  

 

local RunService = game:GetService("RunService");
local u1 = {};
u1.__index = u1;

local function DefaultMakeCell() -- Line: 55
    local Frame = Instance.new("Frame");
    Frame.Name = "Cell";
    Frame.BackgroundColor3 = Color3.fromRGB(32, 32, 32);
    Frame.BorderSizePixel = 0;

    return Frame;
end;

local function Clamp(p2, p3, p4) -- Line: 63
    local v5 = math.min(p4, p2);

    return math.max(p3, v5);
end;

function u1.new(p6, p7, p8) -- Line: 67
    -- upvalues: u1 (copy), DefaultMakeCell (copy), RunService (copy)
    assert(p6 and p7, "ScrollingFrame + content Frame required");
    p8 = p8;
    local v9;

    if p8 then
        v9 = p8.render;
    else
        v9 = p8;
    end;

    assert(v9, "Options.render(cell, index) required");
    local u10 = setmetatable({}, u1);
    u10.List = p6;
    u10.Content = p7;
    u10.CellSize = p8.cellSize;
    u10.Spacing = p8.spacing or Vector2.new(0, 0);
    u10.PadTop = p8.paddingTop or 0;
    u10.PadLeft = p8.paddingLeft or 0;
    u10.BufferRows = p8.bufferRows or 2;
    u10.MakeCell = p8.makeCell or DefaultMakeCell;
    u10.RenderFn = p8.render;
    u10.OnClick = p8.onClick;
    u10.GetCountFn = p8.getCount;
    u10.Count = 0;
    u10.Columns = 1;
    u10.Pool = {};
    u10.FirstVisibleRow = 1;
    u10._Connections = {};
    u10.List.ScrollBarImageTransparency = u10.List.ScrollBarImageTransparency;
    u10.List.CanvasSize = UDim2.fromOffset(0, 0);
    u10.Data = p8.dataSource;
    table.insert(u10._Connections, u10.Data:Subscribe(function() -- Line: 96
        -- upvalues: u10 (copy)
        u10:Reflow();
    end));
    local u11 = false;
    local _Connections = u10._Connections;
    local v12 = u10.List:GetPropertyChangedSignal("CanvasPosition");
    table.insert(_Connections, v12:Connect(function() -- Line: 104
        -- upvalues: u11 (ref)
        u11 = true;
    end));
    table.insert(u10._Connections, RunService.Heartbeat:Connect(function() -- Line: 111
        -- upvalues: u11 (ref), u10 (copy)
        if u11 then
            u11 = false;
            u10:Render();
        end;
    end));
    local u13 = 0;
    local _Connections2 = u10._Connections;
    local v14 = u10.List:GetPropertyChangedSignal("AbsoluteWindowSize");
    table.insert(_Connections2, v14:Connect(function() -- Line: 122
        -- upvalues: u13 (ref), u10 (copy)
        u13 = u13 + 1;
        local u15 = u13;
        task.delay(0.065, function() -- Line: 126
            -- upvalues: u13 (ref), u15 (copy), u10 (ref)
            if u13 == u15 then
                u10:Reflow();
            end;
        end);
    end));

    return u10;
end;

function u1.SetCount(p16, p17) -- Line: 137
    p16.Count = math.max(0, p17);
    p16:Reflow();
end;

function u1.GetCount(p18) -- Line: 142
    return p18.Data and p18.Data:GetCount() or p18.Count;
end;

function u1.ComputeColumns(p19) -- Line: 146
    local X = p19.CellSize.X;
    local X2 = p19.Spacing.X;

    if X <= 0 then
        return 1;
    end;

    local v20 = math.max(0, p19.List.AbsoluteWindowSize.X - p19.PadLeft);
    local v21 = math.floor((v20 + X2) / (X + X2));

    return math.max(1, v21);
end;

function u1.RowsForCount(p22, p23, p24) -- Line: 158
    local v25 = p23 / math.max(1, p24);
    local v26 = math.ceil(v25);

    return math.max(0, v26);
end;

function u1.VisibleRowCount(p27) -- Line: 162
    local v28 = p27.List.AbsoluteWindowSize.Y / math.max(1, p27.CellSize.Y + p27.Spacing.Y);
    local v29 = math.ceil(v28);

    return math.max(1, v29);
end;

function u1.EnsurePool(u30, p31) -- Line: 168
    while #u30.Pool < p31 do
        local u32 = u30.MakeCell();
        u32.Parent = u30.Content;

        if u30.OnClick then
            u32.InputBegan:Connect(function(p33) -- Line: 173
                -- upvalues: u32 (copy), u30 (copy)
                local v34 = p33.UserInputType == Enum.UserInputType.MouseButton1 and u32:GetAttribute("Index");

                if v34 then
                    u30.OnClick(v34, u32);
                end;
            end);
        end;

        table.insert(u30.Pool, u32);
    end;

    while p31 < #u30.Pool do
        u30.Pool[#u30.Pool]:Destroy();
        table.remove(u30.Pool, #u30.Pool);
    end;
end;

function u1.UpdateCanvasHeight(p35, p36) -- Line: 190
    local v37 = p36 == 0 and 0 or p35.PadTop + p36 * (p35.CellSize.Y + p35.Spacing.Y) - p35.Spacing.Y;
    p35.Content.Size = UDim2.new(1, 0, 0, v37);
    p35.List.CanvasSize = UDim2.new(0, 0, 0, v37 + 4);
end;

function u1.Reflow(p38) -- Line: 197
    p38.Columns = p38:ComputeColumns();
    p38:UpdateCanvasHeight((p38:RowsForCount(p38:GetCount(), p38.Columns)));
    p38:EnsurePool((p38:VisibleRowCount() + p38.BufferRows * 2) * p38.Columns);
    p38:Render();
end;

local function YForRow(p39, p40, p41, p42) -- Line: 210
    return p42 + (p39 - 1) * (p40 + p41);
end;

local function XForCol(p43, p44, p45, p46) -- Line: 214
    return p46 + (p43 - 1) * (p44 + p45);
end;

function u1.Render(p47) -- Line: 218
    local v48 = p47:GetCount();

    if v48 <= 0 then
        for _, v in ipairs(p47.Pool) do
            v.Visible = false;
        end;

        return;
    end;

    local X = p47.CellSize.X;
    local Y = p47.CellSize.Y;
    local X2 = p47.Spacing.X;
    local Y2 = p47.Spacing.Y;
    local Columns = p47.Columns;
    local v49 = (p47.List.CanvasPosition.Y - p47.PadTop) / math.max(1, Y + Y2);
    local v50 = math.floor(v49) + 1 - p47.BufferRows;
    local v51 = math.min((1 / 0), v50);
    p47.FirstVisibleRow = math.max(1, v51);
    local v52 = p47:VisibleRowCount();
    local v53 = p47:RowsForCount(v48, Columns);
    local FirstVisibleRow = p47.FirstVisibleRow;
    local v54 = math.min(v52 + p47.BufferRows * 2, v53 - FirstVisibleRow + 1) * Columns;

    for i = 1, #p47.Pool do
        local v55 = p47.Pool[i];

        if i <= v54 then
            local v56 = i - 1;
            local v57 = FirstVisibleRow + math.floor(v56 / Columns);
            local v58 = v56 % Columns + 1;
            local v59 = (v57 - 1) * Columns + v58;

            if v59 <= v48 then
                v55.Visible = true;
                v55.Size = UDim2.fromOffset(X, Y);
                v55.Position = UDim2.fromOffset(p47.PadLeft + (v58 - 1) * (X + X2), p47.PadTop + (v57 - 1) * (Y + Y2));
                v55:SetAttribute("Index", v59);
                local v60 = p47.Data:GetIdAt(v59);

                if v60 then
                    local v61 = p47.Data:GetItem(v60);
                    p47.RenderFn(v55, v60, v59, v61);
                else
                    v55.Visible = false;
                end;
            end;

            local v62 = v59 <= v48;

            if v55.Visible ~= v62 then
                v55.Visible = v62;
            end;
        else
            v55.Visible = false;
        end;
    end;
end;

function u1.Destroy(p63) -- Line: 284
    for _, v in ipairs(p63._Connections) do
        v:Disconnect();
    end;

    for _, v in p63.Pool do
        v:Destroy();
    end;

    p63.Pool = {};
end;

return u1;