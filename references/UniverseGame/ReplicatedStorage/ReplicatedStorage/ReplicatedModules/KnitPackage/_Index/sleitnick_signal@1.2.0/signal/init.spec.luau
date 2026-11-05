  

 

local function AwaitCondition(p1, p2) -- Line: 1
    local v3 = os.clock();
    local v4 = p2 or 10;

    while not p1() do
        if v4 < os.clock() - v3 then
            return false;
        end;

        task.wait();
    end;

    return true;
end;

return function() -- Line: 11
    -- upvalues: AwaitCondition (copy)
    local Parent = require(script.Parent);
    local u5 = nil;

    local function NumConns(p6) -- Line: 17
        -- upvalues: u5 (ref)
        return #(p6 or u5):GetConnections();
    end;

    beforeEach(function() -- Line: 22
        -- upvalues: u5 (ref), Parent (copy)
        u5 = Parent.new();
    end);
    afterEach(function() -- Line: 26
        -- upvalues: u5 (ref)
        u5:Destroy();
    end);
    describe("Constructor", function() -- Line: 30
        -- upvalues: Parent (copy), u5 (ref), AwaitCondition (ref)
        it("should create a new signal and fire it", function() -- Line: 32
            -- upvalues: Parent (ref), u5 (ref)
            expect(Parent.Is(u5)).to.equal(true);
            task.defer(function() -- Line: 34
                -- upvalues: u5 (ref)
                u5:Fire(10, 20);
            end);
            local v7, v8 = u5:Wait();
            expect(v7).to.equal(10);
            expect(v8).to.equal(20);
        end);
        it("should create a proxy signal and connect to it", function() -- Line: 42
            -- upvalues: Parent (ref), AwaitCondition (ref)
            local v9 = Parent.Wrap(game:GetService("RunService").Heartbeat);
            expect(Parent.Is(v9)).to.equal(true);
            local u10 = false;
            v9:Connect(function() -- Line: 46
                -- upvalues: u10 (ref)
                u10 = true;
            end);
            expect(AwaitCondition(function() -- Line: 49
                -- upvalues: u10 (ref)
                return u10;
            end, 2)).to.equal(true);
            v9:Destroy();
        end);
    end);
    describe("FireDeferred", function() -- Line: 55
        -- upvalues: u5 (ref), AwaitCondition (ref)
        it("should be able to fire primitive argument", function() -- Line: 57
            -- upvalues: u5 (ref), AwaitCondition (ref)
            local u11 = nil;
            u5:Connect(function(p12) -- Line: 60
                -- upvalues: u11 (ref)
                u11 = p12;
            end);
            u5:FireDeferred(10);
            expect(AwaitCondition(function() -- Line: 64
                -- upvalues: u11 (ref)
                return u11 == 10;
            end, 1)).to.equal(true);
        end);
        it("should be able to fire a reference based argument", function() -- Line: 67
            -- upvalues: u5 (ref), AwaitCondition (ref)
            local u13 = { 10, 20 };
            local u14 = nil;
            u5:Connect(function(p15) -- Line: 70
                -- upvalues: u14 (ref)
                u14 = p15;
            end);
            u5:FireDeferred(u13);
            expect(AwaitCondition(function() -- Line: 74
                -- upvalues: u13 (copy), u14 (ref)
                return u13 == u14;
            end, 1)).to.equal(true);
        end);
    end);
    describe("Fire", function() -- Line: 79
        -- upvalues: u5 (ref)
        it("should be able to fire primitive argument", function() -- Line: 81
            -- upvalues: u5 (ref)
            local u16 = nil;
            u5:Connect(function(p17) -- Line: 84
                -- upvalues: u16 (ref)
                u16 = p17;
            end);
            u5:Fire(10);
            expect(u16).to.equal(10);
        end);
        it("should be able to fire a reference based argument", function() -- Line: 91
            -- upvalues: u5 (ref)
            local v18 = { 10, 20 };
            local u19 = nil;
            u5:Connect(function(p20) -- Line: 94
                -- upvalues: u19 (ref)
                u19 = p20;
            end);
            u5:Fire(v18);
            expect(u19).to.equal(v18);
        end);
    end);
    describe("ConnectOnce", function() -- Line: 103
        -- upvalues: u5 (ref)
        it("should only capture first fire", function() -- Line: 105
            -- upvalues: u5 (ref)
            local u21 = nil;
            local v23 = u5:ConnectOnce(function(p22) -- Line: 107
                -- upvalues: u21 (ref)
                u21 = p22;
            end);
            expect(v23.Connected).to.equal(true);
            u5:Fire(10);
            expect(v23.Connected).to.equal(false);
            u5:Fire(20);
            expect(u21).to.equal(10);
        end);
    end);
    describe("Wait", function() -- Line: 119
        -- upvalues: u5 (ref)
        it("should be able to wait for a signal to fire", function() -- Line: 121
            -- upvalues: u5 (ref)
            task.defer(function() -- Line: 122
                -- upvalues: u5 (ref)
                u5:Fire(10, 20, 30);
            end);
            local v24, v25, v26 = u5:Wait();
            expect(v24).to.equal(10);
            expect(v25).to.equal(20);
            expect(v26).to.equal(30);
        end);
    end);
    describe("DisconnectAll", function() -- Line: 133
        -- upvalues: u5 (ref)
        it("should disconnect all connections", function() -- Line: 135
            -- upvalues: u5 (ref)
            u5:Connect(function() -- Line: 136
            end);
            u5:Connect(function() -- Line: 137
            end);
            expect(#(nil or u5):GetConnections()).to.equal(2);
            u5:DisconnectAll();
            expect(#(nil or u5):GetConnections()).to.equal(0);
        end);
    end);
    describe("Disconnect", function() -- Line: 145
        -- upvalues: u5 (ref), AwaitCondition (ref)
        it("should disconnect connection", function() -- Line: 147
            -- upvalues: u5 (ref)
            local v27 = u5:Connect(function() -- Line: 148
            end);
            expect(#(nil or u5):GetConnections()).to.equal(1);
            v27:Disconnect();
            expect(#(nil or u5):GetConnections()).to.equal(0);
        end);
        it("should still work if connections disconnected while firing", function() -- Line: 154
            -- upvalues: u5 (ref)
            local u28 = 0;
            local u29 = nil;
            u5:Connect(function() -- Line: 157
                -- upvalues: u28 (ref)
                u28 = u28 + 1;
            end);
            u29 = u5:Connect(function() -- Line: 158
                -- upvalues: u29 (ref), u28 (ref)
                u29:Disconnect();
                u28 = u28 + 1;
            end);
            u5:Connect(function() -- Line: 159
                -- upvalues: u28 (ref)
                u28 = u28 + 1;
            end);
            u5:Fire();
            expect(u28).to.equal(3);
        end);
        it("should still work if connections disconnected while firing deferred", function() -- Line: 164
            -- upvalues: u5 (ref), AwaitCondition (ref)
            local u30 = 0;
            local u31 = nil;
            u5:Connect(function() -- Line: 167
                -- upvalues: u30 (ref)
                u30 = u30 + 1;
            end);
            u31 = u5:Connect(function() -- Line: 168
                -- upvalues: u31 (ref), u30 (ref)
                u31:Disconnect();
                u30 = u30 + 1;
            end);
            u5:Connect(function() -- Line: 169
                -- upvalues: u30 (ref)
                u30 = u30 + 1;
            end);
            u5:FireDeferred();
            expect(AwaitCondition(function() -- Line: 171
                -- upvalues: u30 (ref)
                return u30 == 3;
            end)).to.equal(true);
        end);
    end);
end;