define ['jquery'],($)->

  describe "As a user I want to watch the conference in real time", ()->
    
    #TEST 1
    describe "test that the connection is established", ()->
      it "should connect to the server", ()->
        connected = null
        runs ()->
          connected = false
        testConnected = ->
          connected = $('.js-status').hasClass('connected')
          connected
        waitsFor testConnected , "The connection should be established" , 5000
        runs ()->
          expect(connected).toBe(true)

    #TEST 2
    describe "Data received is a slide and what kind it is",()->
      it "should "
      #TODO with database

    #TEST 3
    describe "that if I receive two slide the last one which contains title WORLD is shown",()->
      it "should display the last slide only", ()->
        found = null
        runs ()->
          found = false
        testLastSlide = ->
          lastSlideText = $('#SlideList>div').last().find('h1').text()
          if lastSlideText is "WORLD"
            found = true
            console.log 'found World'
            return true
          else
            return false
        waitsFor testLastSlide, "Second slide found", 10000
        runs ()->
          slideCount = 0
          $('#SlideList>div>div').each (index,elem)->
            slideCount++
            console.log  elem
            if index is 1
              expect($(elem).css('display')).toBe('block')

            else
              expect($(elem).css('display')).toBe('none')
          expect(found).toBe(true)
          expect(slideCount).toBe(2)

    
  