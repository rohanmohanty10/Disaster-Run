 

 

return table.freeze({
    Enabled = true,
    EmptyChance = 0.15,
    MaxGemsPerCrossing = 48,
    EdgeMargin = 9,
    SafeMargin = 9,
    Separation = 15,
    HoverHeight = 2.8,
    PickupRadius = 3.4,
    VerticalTolerance = 5,
    PollInterval = 0.08,
    MaxSampleGap = 0.6,
    MaxSampleSpeed = 110,
    PositionSlack = 5,
    MaxVisibleDistance = 190,
    Layouts = { {
            Weight = 55,
            Min = 3,
            Max = 5
        }, {
            Weight = 35,
            Min = 5,
            Max = 8
        }, {
            Weight = 10,
            Min = 8,
            Max = 12
        } },
    StackValues = { {
            Weight = 30,
            Value = 4
        }, {
            Weight = 25,
            Value = 5
        }, {
            Weight = 17,
            Value = 5
        }, {
            Weight = 12,
            Value = 6
        }, {
            Weight = 8,
            Value = 6
        }, {
            Weight = 5,
            Value = 7
        }, {
            Weight = 3,
            Value = 7
        } }
});