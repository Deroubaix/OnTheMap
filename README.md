# OnTheMap


iOS Developer Nanodegree Project

The On The Map is result of **iOS Networking with Swift** lesson of **Udacity's iOS Developer Nanodegree** course.

The On The Map app allows udacity students to share their location and a URL with their fellow students. To visualize this data, On The Map uses a map with pins for location and pin annotations for student names and URLs and in the Second tab it shows its list in a Table View.

The user First authenticates the login screen using their Udacities Credentials.

After logging in , the app gets the required data to fill in locations and links previously posted by other udacity students. These links can point to any URL that a student shares. After viewing the information posted by other students, a user can post their own location and link.

## Implementation
The app has five view controller scenes:

**Login** - allows the user to log in using their Udacity credentials.

When the user taps the Login button, the app will attempt to authenticate with Udacity’s servers. Clicking on the Sign Up link will open Safari to the Udacity sign-in page.

If the login does not succeed, the user will be presented with an alert view specifying whether it was a failed network connection, or an incorrect email and password.

**MapView** - displays a map with pins specifying the last 100 locations posted by students.

When the user taps a pin, it displays the pin annotation popup, with the student’s name (pulled from their Udacity profile) and the link associated with the student’s pin.

Tapping anywhere within the annotation will launch Safari and direct it to the link associated with the pin.

**TableView** - displays the most recent 100 locations posted by students in a table. Each row displays the name from the student’s Udacity profile and the link which they posted. Tapping on the row launches Safari and opens the link associated with the student.

**Add Location** - allows users to add their location and a their contact(linkedin or website). If the user already added their location and website they can overwrite it if they choose to do so through a UIAlert.

When the user clicks on the “Find” button, the app will display the Submit View Controller. If the forward geocode fails, the app will display an alert view notifying the user.

**Submit** - shows a map with the location the user added. When the user clicks the "Submit" button it will be display on the MapView and TableView with the user location and website.

## Requirements
Xcode 8.0 Swift 3.0
