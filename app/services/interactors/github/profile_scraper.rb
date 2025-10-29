require "playwright"

module Interactors
  module Github
    class ProfileScraper
      include Interactor

      def call
        Playwright.create(playwright_cli_executable_path: "./node_modules/.bin/playwright") do |playwright|
          page, browser = load_page(playwright)
          add_page_context(page)

          Organizers::ProfileScraperOrganizer.call(context)
          browser.close
        end
      rescue => e
        context.fail!(error: e.message)
      end

      private

      def add_page_context(page)
        context.page    = page
        context.sidebar = page.query_selector(".Layout-sidebar .js-profile-editable-replace")
      end

      def load_page(playwright)
        browser      = playwright.chromium.launch(**chromium_launch_options)
        context_page = browser.new_context(viewport: { width: 640, height: 480 })
        page         = context_page.new_page

        page.goto(context.url)
        page.wait_for_selector("#user-profile-frame #js-contribution-activity-description")

        [ page, browser ]
      end

      def chromium_launch_options
        {
          headless: true,
          args: [
            "--no-sandbox",
            "--disable-gpu",
            "--disable-dev-shm-usage",
            "--disable-extensions",
            "--disable-background-networking",
            "--disable-sync",
            "--disable-translate",
            "--disable-software-rasterizer",
            "--disable-accelerated-2d-canvas"
          ],
          timeout: 60000
        }
      end

      def text_normalize(element)
        element&.text_content&.strip
      end
    end
  end
end
