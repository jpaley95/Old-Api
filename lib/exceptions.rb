module CustomException
  class UnprocessableEntity < StandardError; end
  class Unauthorized < StandardError; end
  class Forbidden < StandardError; end
end