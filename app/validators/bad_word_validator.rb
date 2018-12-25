class BadWordValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    cache = ActiveSupport::Cache::MemoryStore.new(expires_in: 90.minutes)
    bad_words = cache.fetch('bad_words') do
      File.readlines('repos/List-of-Dirty-Naughty-Obscene-and-Otherwise-Bad-Words/en').map { |a| a.strip }
    end

    value_array = ActionController::Base.helpers.strip_tags(value.to_s).gsub(/[^0-9a-z ]/i, '').split

    if value_array.length > 0
      for word in value_array
        if bad_words.include? word.downcase
          record.errors[attribute] << (options[:message] || " must not contain bad words.")
          break
        end
      end
    end
  end
end
