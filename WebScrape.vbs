' Declare the objXMLHTTP variable to hold the HTTP request object
Dim objXMLHTTP, objShell, headline, strURL, htmlDoc, headlines

' Initialize an array of URLs for the news websites we want to scrape
Dim strURLs
strURLs = Array("https://www.bbc.co.uk/", "https://www.cnn.com/", "https://www.nytimes.com/")

' Create a shell object to run external commands
Set objShell = CreateObject("WScript.Shell")

' Loop through each URL in the strURLs array
For Each strURL In strURLs
    ' Create new instances of the HTTP request and HTML document objects for each URL
    ' This ensures we start with a fresh object for each iteration
    Set objXMLHTTP = CreateObject("MSXML2.ServerXMLHTTP.6.0")
    Set htmlDoc = CreateObject("htmlfile")

    ' Open an HTTP GET request to the current URL
    objXMLHTTP.Open "GET", strURL, False

    ' Set the User-Agent header to mimic a web browser
    objXMLHTTP.setRequestHeader "User-Agent", "Mozilla/5.0"

    ' Send the HTTP request
    objXMLHTTP.send ""

    ' Check if the HTTP request was successful (Status code 200)
    If objXMLHTTP.Status = 200 Then
        ' Write the HTTP response text into the HTML document object
        htmlDoc.write objXMLHTTP.responseText
    End If

    ' Retrieve all the elements that have the tag name "h2" (assumed to be headlines)
    Set headlines = htmlDoc.getElementsByTagName("h2")
    
    ' Output the source of the headlines
    WScript.Echo "Headlines from " & strURL
    
    ' Loop through each "h2" element and output its inner text
    For Each headline In headlines
        WScript.Echo headline.innerText

        ' ... (rest of your code)
        Dim cmd
        cmd = ".\myenv\Scripts\python.exe .\sentiment_analysis.py " & Chr(34) & headline.innerText & Chr(34)

        ' Call the Python script to perform sentiment analysis and capture the output
        On Error Resume Next
        Set objExec = objShell.Exec(cmd)
        ' ... (rest of your code)

        
        If Err.Number <> 0 Then
            WScript.Echo "Failed to run command: " & cmd
            WScript.Echo "Error " & Err.Number & ": " & Err.Description
            Err.Clear
        Else
            ' Loop to make sure we capture all output
            Do While Not objExec.StdOut.AtEndOfStream
                WScript.Echo objExec.StdOut.ReadLine()
            Loop
        End If
        On Error GoTo 0
    Next

    ' Add a blank line for readability between sets of headlines from different URLs
    WScript.Echo ""

    ' Clear the HTTP and HTML document objects to free up resources
    Set objXMLHTTP = Nothing
    Set htmlDoc = Nothing
Next

' Reminder: Run this script using CScript to execute it in the console
