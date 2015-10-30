class Randomizer
  @gender_specific = "not assigned"
  @number = 0
  @group_id = 0

  class << self
    def gender_specific
      @gender_specific
    end

    def gender_specific=(option)
      @gender_specific = option
    end

    def number
      @number
    end

    def number=(groups)
      @number = groups
    end

    def group_id
      @group_id
    end

    def group_id=(id)
      @group_id = id
    end
  end

end