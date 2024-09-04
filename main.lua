local DataConverter = {}

local function isSerializable(v)
    local t = typeof(v)
    return t == "table" or t == "Vector3" or t == "CFrame" or t == "Color3" or t == "BrickColor" or t == "NumberRange" or t == "Rect"
end

function DataConverter.ToTable(instance)
    if not instance then return {} end
    local data = {}
    for _, v in pairs(instance:GetChildren()) do
        if v:IsA("ValueBase") then
            data[v.Name] = v.Value
        elseif isSerializable(v.Value) then
            data[v.Name] = DataConverter.ToTable(v)
        end
    end
    return data
end

function DataConverter.ToInstance(data, parent)
    if type(data) ~= "table" then return end
    for k, v in pairs(data) do
        local t = typeof(v)
        if t == "table" then
            local folder = Instance.new("Folder")
            folder.Name = k
            DataConverter.ToInstance(v, folder)
            folder.Parent = parent
        elseif t == "Vector3" then
            local vector = Instance.new("Vector3Value")
            vector.Name = k
            vector.Value = v
            vector.Parent = parent
        elseif t == "CFrame" then
            local cframe = Instance.new("CFrameValue")
            cframe.Name = k
            cframe.Value = v
            cframe.Parent = parent
        elseif t == "Color3" then
            local color = Instance.new("Color3Value")
            color.Name = k
            color.Value = v
            color.Parent = parent
        elseif t == "BrickColor" then
            local bcolor = Instance.new("BrickColorValue")
            bcolor.Name = k
            bcolor.Value = v
            bcolor.Parent = parent
        elseif t == "number" then
            local num = Instance.new("NumberValue")
            num.Name = k
            num.Value = v
            num.Parent = parent
        elseif t == "string" then
            local str = Instance.new("StringValue")
            str.Name = k
            str.Value = v
            str.Parent = parent
        elseif t == "boolean" then
            local bool = Instance.new("BoolValue")
            bool.Name = k
            bool.Value = v
            bool.Parent = parent
        elseif t == "NumberRange" then
            local range = Instance.new("NumberValue")
            range.Name = k
            range.Value = v.Min
            range.Parent = parent
            local maxRange = Instance.new("NumberValue")
            maxRange.Name = k.."Max"
            maxRange.Value = v.Max
            maxRange.Parent = parent
        elseif t == "Rect" then
            local rect = Instance.new("Vector2Value")
            rect.Name = k
            rect.Value = Vector2.new(v.Min.X, v.Min.Y)
            rect.Parent = parent
            local maxRect = Instance.new("Vector2Value")
            maxRect.Name = k.."Max"
            maxRect.Value = Vector2.new(v.Max.X, v.Max.Y)
            maxRect.Parent = parent
        end
    end
end

return DataConverter
