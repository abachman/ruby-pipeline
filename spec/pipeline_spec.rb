RSpec.describe Pipeline do
  it "has a version number" do
    expect(Pipeline::VERSION).not_to be nil
  end

  it "is callable" do
    pipeline = Pipeline.create([])
    expect(pipeline).to respond_to(:call)
  end
end
