  

 

return function() -- Line: 1
    local Signal = require(script.Parent.Signal);
    it("should construct from nothing", function() -- Line: 4
        -- upvalues: Signal (copy)
        local v1 = Signal.new();
        expect(v1).to.be.ok();
    end);
    it("should fire connected callbacks", function() -- Line: 10
        -- upvalues: Signal (copy)
        local u2 = 0;

        local function v5(p3, p4) -- Line: 15
            -- upvalues: u2 (ref)
            expect(p3).to.equal("Hello World");
            expect(p4).to.equal(7);
            u2 = u2 + 1;
        end;

        local v6 = Signal.new();
        local v7 = v6:connect(v5);
        v6:fire("Hello World", 7);
        expect(u2).to.equal(1);
        v7:disconnect();
        v6:fire("Hello World", 7);
        expect(u2).to.equal(1);
    end);
    it("should disconnect handlers", function() -- Line: 34
        -- upvalues: Signal (copy)
        local v8 = Signal.new();
        v8:connect(function() -- Line: 35
            error("Callback was called after disconnect!");
        end):disconnect();
        v8:fire();
    end);
    it("should fire handlers in order", function() -- Line: 47
        -- upvalues: Signal (copy)
        local v9 = Signal.new();
        local u10 = 0;
        local u11 = 0;

        local function v12() -- Line: 58
            -- upvalues: u10 (ref), u11 (ref)
            expect(u10).to.equal(1);
            expect(u11).to.equal(0);
            u11 = u11 + 1;
        end;

        v9:connect(function() -- Line: 52
            -- upvalues: u10 (ref), u11 (ref)
            expect(u10).to.equal(0);
            expect(u11).to.equal(0);
            u10 = u10 + 1;
        end);
        v9:connect(v12);
        v9:fire();
        expect(u10).to.equal(1);
        expect(u11).to.equal(1);
    end);
    it("should continue firing despite mid-event disconnection", function() -- Line: 72
        -- upvalues: Signal (copy)
        local v13 = Signal.new();
        local u14 = 0;
        local u15 = 0;
        local u16 = nil;
        u16 = v13:connect(function() -- Line: 78
            -- upvalues: u16 (ref), u14 (ref)
            u16:disconnect();
            u14 = u14 + 1;
        end);
        v13:connect(function() -- Line: 83
            -- upvalues: u15 (ref)
            u15 = u15 + 1;
        end);
        v13:fire();
        expect(u14).to.equal(1);
        expect(u15).to.equal(1);
    end);
    it("should skip listeners that were disconnected during event evaluation", function() -- Line: 93
        -- upvalues: Signal (copy)
        local v17 = Signal.new();
        local u18 = 0;
        local u19 = 0;
        local u20 = nil;
        v17:connect(function() -- Line: 100
            -- upvalues: u18 (ref), u20 (ref)
            u18 = u18 + 1;
            u20:disconnect();
        end);
        u20 = v17:connect(function() -- Line: 105
            -- upvalues: u19 (ref)
            u19 = u19 + 1;
        end);
        v17:fire();
        expect(u18).to.equal(1);
        expect(u19).to.equal(0);
    end);
    it("should throw an error if the argument to `connect` is not a function", function() -- Line: 115
        -- upvalues: Signal (copy)
        local u21 = Signal.new();
        expect(function() -- Line: 117
            -- upvalues: u21 (copy)
            u21:connect("not a function");
        end).to.throw();
    end);
    it("should throw an error when disconnecting more than once", function() -- Line: 122
        -- upvalues: Signal (copy)
        local v22 = Signal.new():connect(function() -- Line: 125
        end);
        expect(v22.disconnect).never.to.throw();
        expect(v22.disconnect).to.throw();
    end);
    it("should throw an error when subscribing during dispatch", function() -- Line: 133
        -- upvalues: Signal (copy)
        local v23 = {
            _isDispatching = false
        };
        local u24 = Signal.new(v23);
        u24:connect(function() -- Line: 139
            -- upvalues: u24 (copy)
            u24:connect(function() -- Line: 141
            end);
        end);
        v23._isDispatching = true;
        expect(function() -- Line: 145
            -- upvalues: u24 (copy)
            u24:fire();
        end).to.throw();
    end);
    it("should throw an error when unsubscribing during dispatch", function() -- Line: 150
        -- upvalues: Signal (copy)
        local v25 = {
            _isDispatching = false
        };
        local u26 = Signal.new(v25);
        local u27 = nil;
        u27 = u26:connect(function() -- Line: 157
            -- upvalues: u27 (ref)
            u27.disconnect();
        end);
        v25._isDispatching = true;
        expect(function() -- Line: 162
            -- upvalues: u26 (copy)
            u26:fire();
        end).to.throw();
    end);
end;