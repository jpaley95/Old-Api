module CustomException
  class UnprocessableEntity < StandardError; end
  class Forbidden < StandardError; end
end