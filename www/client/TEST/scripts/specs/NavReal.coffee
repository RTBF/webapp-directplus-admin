define ['jquery'],($)->

  describe "As user I want switch navigation",()->
    #TEST1
    describe "test that I am in navigation mode", ()->
      describe "test that more than one slide and the last slide is not the current one. when I received a new one, it is not showed ", ()->
        it "should not display the new slide", ()->
          found = null
          current= null
          runs ()->
            found = false
            current = 0
          testNav =() ->
            slideCountFirst = 0
            $('#SlideList>div>div').each (index,elem)->
              slideCountFirst++
              if $(elem).css('display') is 'block'
                current = slideCountFirst - 1 
                console.log 'Test Current: ', current
            display = $('#SlideList>div>div').last().css('display')
            if display is 'none' 
              if slideCountFirst > 2
                found = true
                testNewSlide = ()->
                  slideCountTwo = 0 
                  $('#SlideList>div>div').each (index,elem)->
                    slideCountTwo++
                    console.log "Test Slide Count Two", slideCountTwo
                    console.log "Test slide Count First", slideCountFirst
                  if slideCountTwo > slideCountFirst
                    return true
                  else
                    return false
                waitsFor testNewSlide, "new slide just comes", 10000
                return true
              else
                return false
          waitsFor testNav, "we are in navigation" , 10000
          runs ()->
            currentSlide = $('#SlideList>div>div').get(current)
            console.log currentSlide
            expect($(currentSlide).css('display')).toBe('block')
            allSlide = 0
            $('#SlideList>div>div').each (index,elem)->
              allSlide++
              slide = $('#SlideList>div>div').get(allSlide-1)
              if current != (allSlide-1)
                expect($(elem).css('display')).toBe('none')
                # ...

    describe "test that I am back into RealTime mode", () ->
      it "should show the new slide that arrived", ()->
        #...
              





            


