define ['jquery'],($)->

  describe "As user I want to be able to go back to a previous slide",()->
    #TEST1
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
    
    #TEST2
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

   
