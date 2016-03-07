class CreatePlanService
  def call
    p1 = Plan.where(name: '6 meals per week').first_or_initialize do |p|
      p.amount = 5965
      p.interval = 'week'
      p.stripe_id = 'six_meal'
    end
    p1.save!(:validate => false)
    p2 = Plan.where(name: '12 meals per week').first_or_initialize do |p|
      p.amount = 11940
      p.interval = 'week'
      p.stripe_id = 'twelve_meal'
    end
    p2.save!(:validate => false)
    p3 = Plan.where(name: '18 meals per week').first_or_initialize do |p|
      p.amount = 17910
      p.interval = 'week'
      p.stripe_id = 'eighteen_meal'
    end
    p3.save!(:validate => false)
  end
end
