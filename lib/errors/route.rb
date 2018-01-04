##
# ruby-crisp-api
#
# Copyright 2018, Valerian Saliou
# Author: Valerian Saliou <valerian@valeriansaliou.name>
##

class RouteError < StandardError
  def initialize(reason)
    @reason = reason

    super(reason)
  end

  def to_s
    @reason
  end
end
