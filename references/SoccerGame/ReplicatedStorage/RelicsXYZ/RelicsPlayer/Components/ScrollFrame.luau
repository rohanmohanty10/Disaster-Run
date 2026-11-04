  

local React = require(script.Parent.Parent.Parent.Shared.React);

return function(p1: table) -- Line: 66, Name: ScrollFrame
    -- upvalues: React (copy)
    local u2 = React.useRef(nil);
    local u3 = React.useRef(nil);
    local u4 = React.useRef(nil);
    local u5 = React.useRef(nil);
    local List = p1.List;
    local Grid = p1.Grid;

    if p1.ScrollRef then
        u4 = p1.ScrollRef;
    end;

    React.useEffect(function() -- Line: 79
        -- upvalues: u2 (copy), u5 (copy), u3 (copy), u4 (ref)
        local current = u2.current;
        local current2 = u5.current;
        local current3 = u4.current;

        if not (current and (current3 and (u3.current and current2))) then
            return;
        end;

        local function update() -- Line: 89
            -- upvalues: current (copy), current2 (copy), current3 (copy)
            local v6 = current2.AbsoluteContentSize / (current.AbsoluteSize.X / 2000);
            current3.CanvasSize = UDim2.fromOffset(v6.X, v6.Y);
        end;

        local PropertyChangedSignal = current3:GetPropertyChangedSignal("AbsoluteSize");
        local PropertyChangedSignal2 = current2:GetPropertyChangedSignal("AbsoluteContentSize");
        local PropertyChangedSignal3 = current:GetPropertyChangedSignal("AbsoluteSize");
        PropertyChangedSignal:Connect(update);
        PropertyChangedSignal3:Connect(update);
        PropertyChangedSignal2:Connect(update);
        local v7 = current2.AbsoluteContentSize / (current.AbsoluteSize.X / 2000);
        current3.CanvasSize = UDim2.fromOffset(v7.X, v7.Y);
    end);
    local createElement = React.createElement;
    local Fragment = React.Fragment;
    local v8 = {};
    local createElement2 = React.createElement;
    local v9 = {
        Size = p1.Size,
        CanvasSize = UDim2.new(),
        Position = p1.Position,
        LayoutOrder = p1.LayoutOrder,
        AnchorPoint = p1.AnchorPoint,
        ClipsDescendants = p1.ClipsDescendants,
        BorderSizePixel = p1.BorderSizePixel or 0,
        BorderColor3 = p1.BorderColor,
        ScrollingDirection = p1.ScrollingDirection,
        ScrollBarThickness = p1.ScrollBarThickness or 2,
        ScrollBarImageTransparency = p1.ScrollBarImageTransparency,
        ScrollBarImageColor3 = p1.ScrollBarImageColor3,
        BackgroundTransparency = p1.Transparency or 1,
        BackgroundColor3 = p1.Color,
        TopImage = p1.TopImage,
        MidImage = p1.MidImage,
        BottomImage = p1.BottomImage,
        ElasticBehavior = p1.ElasticBehavior,
        HorizontalScrollBarInset = p1.HorizontalScrollBarInset,
        VerticalScrollBarInset = p1.VerticalScrollBarInset,
        [React.Change.CanvasPosition] = p1.OnPositionChanged,
        ZIndex = p1.ZIndex or 0,
        ref = u4
    };
    local v10 = {};
    local createElement3 = React.createElement;
    local v11 = {
        BackgroundTransparency = 1,
        AutomaticSize = p1.AutomaticCanvasSize or Enum.AutomaticSize.XY,
        Size = p1.CanvasSize or UDim2.new(),
        ref = u3
    };
    local children = p1.children;
    local v12 = {};
    local v13 = List and not Grid and React.createElement("UIListLayout", {
        Padding = List.Padding,
        Wraps = List.Wraps,
        FillDirection = List.FillDirection,
        HorizontalFlex = List.HorizontalFlex,
        HorizontalAlignment = List.HorizontalAlignment,
        ItemLineAlignment = List.ItemLineAlignment,
        VerticalAlignment = List.VerticalAlignment,
        VerticalFlex = List.VerticalFlex,
        SortOrder = List.SortOrder,
        ref = u5
    });
    v12.List = v13;
    local v14 = Grid and not List and React.createElement("UIGridLayout", {
        CellSize = Grid.CellSize,
        CellPadding = Grid.CellPadding,
        FillDirection = Grid.FillDirection,
        HorizontalAlignment = Grid.HorizontalAlignment,
        VerticalAlignment = Grid.VerticalAlignment,
        StartCorner = Grid.StartCorner,
        SortOrder = Grid.SortOrder,
        ref = u5
    });
    v12.Grid = v14;
    v10.Canvas = createElement3("Frame", v11, children, v12);
    v10.MeasureScale = React.createElement("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.fromOffset(2000, 0),
        ref = u2
    });
    v8.ScrollingFrame = createElement2("ScrollingFrame", v9, v10);

    return createElement(Fragment, nil, v8);
end;