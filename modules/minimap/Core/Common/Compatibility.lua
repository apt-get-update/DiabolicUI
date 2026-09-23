do
    local FrameMethods = getmetatable(CreateFrame("Frame")).__index
    if not FrameMethods.RegisterUnitEvent then
        local unitEventFilters = setmetatable({}, { __mode = "k" })

        function FrameMethods:RegisterUnitEvent(event, unit1, unit2)
            self:RegisterEvent(event)
            if not unitEventFilters[self] then
                unitEventFilters[self] = {}
            end
            unitEventFilters[self][event] = { unit1, unit2 }
        end

        local origIsEventRegistered = FrameMethods.IsEventRegistered
        function FrameMethods:IsEventRegistered(event)
            local isRegistered = origIsEventRegistered(self, event)
            if isRegistered and unitEventFilters[self] and unitEventFilters[self][event] then
                local filter = unitEventFilters[self][event]
                return isRegistered, filter[1], filter[2]
            end
            return isRegistered
        end
    end
end
