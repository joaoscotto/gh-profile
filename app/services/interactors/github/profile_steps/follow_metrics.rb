module Interactors
  module Github
    module ProfileSteps
      class FollowMetrics
        include Interactor

        def call
          context.sidebar.query_selector_all("a[href*='tab=follow']").each do |link|
            metric = link.get_attribute("href").split("tab=").last
            context.data[metric.to_sym] = link.query_selector("span.text-bold").text_content
          end
        end
      end
    end
  end
end
