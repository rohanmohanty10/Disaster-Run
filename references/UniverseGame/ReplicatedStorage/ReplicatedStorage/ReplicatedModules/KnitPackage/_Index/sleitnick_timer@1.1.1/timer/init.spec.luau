  

 

return function() -- Line: 1
    local Parent = require(script.Parent);
    describe("Timer", function() -- Line: 5
        -- upvalues: Parent (copy)
        local u1 = nil;
        beforeEach(function() -- Line: 9
            -- upvalues: u1 (ref), Parent (ref)
            u1 = Parent.new(0.1);
            u1.TimeFunction = os.clock;
        end);
        afterEach(function() -- Line: 14
            -- upvalues: u1 (ref)
            if u1 then
                u1:Destroy();
                u1 = nil;
            end;
        end);
        it("should create a new timer", function() -- Line: 21
            -- upvalues: Parent (ref), u1 (ref)
            expect(Parent.Is(u1)).to.equal(true);
        end);
        it("should tick appropriately", function() -- Line: 25
            -- upvalues: u1 (ref)
            local v2 = os.clock();
            u1:Start();
            u1.Tick:Wait();
            local v3 = os.clock() - v2;
            expect(v3).to.be.near(v3, 0.02);
        end);
        it("should start immediately", function() -- Line: 33
            -- upvalues: u1 (ref)
            local v4 = os.clock();
            local u5 = nil;
            u1.Tick:Connect(function() -- Line: 36
                -- upvalues: u5 (ref)
                if not u5 then
                    u5 = os.clock();
                end;
            end);
            u1:StartNow();
            u1.Tick:Wait();
            expect(u5).to.be.a("number");
            expect(u5 - v4).to.be.near(0, 0.02);
        end);
        it("should stop", function() -- Line: 48
            -- upvalues: u1 (ref)
            local u6 = 0;
            u1.Tick:Connect(function() -- Line: 50
                -- upvalues: u6 (ref)
                u6 = u6 + 1;
            end);
            u1:StartNow();
            u1:Stop();
            task.wait(1);
            expect(u6).to.equal(1);
        end);
        it("should detect if running", function() -- Line: 59
            -- upvalues: u1 (ref)
            expect(u1:IsRunning()).to.equal(false);
            u1:Start();
            expect(u1:IsRunning()).to.equal(true);
            u1:Stop();
            expect(u1:IsRunning()).to.equal(false);
            u1:StartNow();
            expect(u1:IsRunning()).to.equal(true);
            u1:Stop();
            expect(u1:IsRunning()).to.equal(false);
        end);
    end);
end;