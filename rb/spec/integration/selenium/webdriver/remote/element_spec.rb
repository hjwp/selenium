# encoding: utf-8
#
# Licensed to the Software Freedom Conservancy (SFC) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The SFC licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

require_relative '../spec_helper'

module Selenium
  module WebDriver
    compliant_on driver: :remote do
      describe Element do
        before do
          driver.file_detector = ->(_str) { __FILE__ }
        end

        after do
          driver.file_detector = nil
        end

        not_compliant_on browser: [:phantomjs, :safari, :marionette, :edge] do
          it 'uses the file detector' do
            driver.navigate.to url_for('upload.html')

            driver.find_element(id: 'upload').send_keys('random string')
            driver.find_element(id: 'go').submit

            driver.switch_to.frame('upload_target')
            body = driver.find_element(xpath: '//body')
            expect(body.text).to include('uses the set file detector')
          end
        end
      end
    end
  end # WebDriver
end # Selenium
