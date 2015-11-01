args = {}
settings = args[1]
return doctype()(
	tag"head"(
		tag"title" "CPaste WebPaste",
		tag"script"[{src="//code.jquery.com/jquery-1.11.3.min.js"}](),
		tag"script"[{src="//code.jquery.com/jquery-migrate-1.2.1.min.js"}](),
		tag"script"([[
			$(document).ready(function() {
				$('#submit').click(function() {
					var sentType = "plain";
					var pasteTypes = document.getElementsByName("pasteType");
					if (pasteTypes[0].checked) sentType = "plain";
					if (pasteTypes[1].checked) sentType = "raw";
					if (pasteTypes[2].checked) sentType = "html";
					$.ajax({
						data: {
							c: $('textarea').val(),
							type: sentType
						},
						type: "POST",
						url: $('#submit').attr('action'),
						success: function(response) {
							$('#resultholder').css({
								display: "block",
								opacity: "1"
							});
							$('#result').html(response);
							$('#result').attr("href", response);
							console.log( response )
						}
					});
					return false
				});
				
				$('#close').click(function() {
					$('#resultholder').css({
						opacity: "0"
					});
					setTimeout(function() {
						$('#resultholder').css("display","");
					}, 200 /*ms*/);
				});
			});
		]]),
		tag"style"[{type="text/css"}]([[
			body {
				overflow: hidden;
				margin: 0px;
				width: 100%;
				height: 100%;
				background-color: #010101;
			}
			button {
				margin: 4px;
				padding: 8px;
				background-color: #222;
				border: none;
				border-radius: 2px;
				color: #dcdcdc;
				text-decoration: none;
				transition: 0.2s;
			}
			button:hover {
				background-color: #333;
			}
			button:active {
				background-color: #666;
			}
			#submit {
				position: absolute;
				right: 0px;
				bottom: 0px;
			}
			.pasteTypeHolder {
				padding: 4px;
				color: #dcdcdc;
				position: absolute;
				bottom: 4px;
				left: 4px;
			}
			textarea {
				background-color: #010101;
				border: none;
				color: #fff;
				width: 100%;
				position: absolute;
				top: 0px;
				bottom: 40px;
				resize: none;
				outline: 0;
			}
			#resultholder {
				padding: 8px;
				background-color: #222;
				border: none;
				border-radius: 2px;
				position: fixed;
				left: 50%;
				top: 50%;
				transform: translate( -50%, -50% );
				display: none;
				opacity: 0;
				transition: 0.2s;
			}
			#result {
				color: #dcdcdc;
			}
		]])
	),
	tag"body"(
		tag"textarea"[{name="c", placeholder="Hello World!"}](),
		tag"button"[{id="submit",action=ret.url}]("Paste!"),
		tag"div"[{class="pasteTypeHolder"}](
			tag"input"[{type="radio",class="pasteType",name="pasteType",id="radio1",checked=""}]("Normal"),
			tag"input"[{type="radio",class="pasteType",name="pasteType",id="radio2"}]("Raw"),
			tag"input"[{type="radio",class="pasteType",name="pasteType",id="radio3"}]("HTML")
		),
		tag"div"[{id="resultholder"}](
			tag"a"[{id="result"}],
			tag"button"[{id="close"}]("Close")
		)
	)
):render()
