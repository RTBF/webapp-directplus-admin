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

    
  describe "As user I want to be able to go back to a previous slide",()->
    #TEST4
    describe "test that the previous slide is shown", ()->
      it "should display the previous slide received", ()->
        
        found = null
        runs ()->
          found = false
        testpreviousSlide = ->
            displayTxt = $('#SlideList>div>div').last().css('display')
            if displayTxt is 'none'
              found = true
              console.log 'none found'
              return true
            else
              return false
        waitsFor testpreviousSlide, "previous slide found", 10000
        runs ()->
          slideCount = 0
          $('#SlideList>div>div').each (index,elem)->
            slideCount++
            console.log  elem
            if index is 1
              expect($(elem).css('display')).toBe('none')

            else
              expect($(elem).css('display')).toBe('block')
          expect(found).toBe(true)
          expect(slideCount).toBe(2)
    #TEST5
    describe "test that the next slide is shown", ()->
      it "should display the next slide received", ()->
        
        found = null
        runs ()->
          found = false
        testpreviousSlide = ->
            displayTxt = $('#SlideList>div>div').last().css('display')
            if displayTxt is 'none'

              found = true
              testnextSlide = ->
                displayTxtwo = $('#SlideList>div>div').last().css('display')
                if displayTxtwo is 'block'
                  found = true
                  return true
                else
                return false
              waitsFor testnextSlide, "next slide found", 10000
              return true
            else
              return false
        waitsFor testpreviousSlide, "previous slide found", 10000
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



