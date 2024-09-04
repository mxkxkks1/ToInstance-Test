local DataConverter = require(script.Parent.DataConverter)

local data = {
    pos = Vector3.new(1, 2, 3),
    color = Color3.new(1, 0, 0),
    range = NumberRange.new(0, 10),
    rect = Rect.new(0, 0, 100, 100)
}

local folder = Instance.new("Folder")
DataConverter.ToInstance(data, folder)

local convertedData = DataConverter.ToTable(folder)
print(convertedData)
