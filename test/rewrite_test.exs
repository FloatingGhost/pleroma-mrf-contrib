defmodule MRFContrib.RewritePolicyTest do
    use ExUnit.Case
    alias MRFContrib.RewritePolicy

    @instance "https://invidio.us"

    describe "invidious" do
        test "replaces stuff" do
            assert RewritePolicy.sub("<a href=\"https://youtu.be/SckcB099zrg\">link</a>", {:invidious, @instance}) == "<a href=\"https://invidio.us/watch?v=SckcB099zrg\">link</a>"

            assert RewritePolicy.sub("<a href=\"https://www.youtube.com/watch?v=5Ez225PlwHA\">link</a>", {:invidious, @instance}) == "<a href=\"https://invidio.us/watch?v=5Ez225PlwHA\">link</a>"

            assert RewritePolicy.sub("<a href=\"https://youtube.com/watch?v=5Ez225PlwHA\">link</a>", {:invidious, @instance}) == "<a href=\"https://invidio.us/watch?v=5Ez225PlwHA\">link</a>"
        end
    end
end
