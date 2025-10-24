require 'rails_helper'

RSpec.describe Taxation::Calculator do
  it 'computes IVA and IRPF over base' do
    calc = described_class.new(iva_rate: 21, irpf_rate: 15)
    out = calc.for_base(100_00) # 100.00€

    expect(out[:iva_cents]).to eq(21_00)
    expect(out[:irpf_cents]).to eq(15_00)
    expect(out[:total_cents]).to eq(106_00)
  end
end
