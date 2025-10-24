module Taxation
  class Calculator
    def initialize(iva_rate:, irpf_rate:)
      @iva = BigDecimal(iva_rate.to_s)
      @irpf = BigDecimal(irpf_rate.to_s)
    end

    # base_cents is base without IVA; returns hash of computed cents
    def for_base(base_cents)
      iva = (base_cents * @iva / 100).to_i
      irpf = (base_cents * @irpf / 100).to_i
      total = base_cents + iva - irpf
      { iva_cents: iva, irpf_cents: irpf, total_cents: total }
    end
  end
end
